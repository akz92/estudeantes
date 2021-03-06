require 'rails_helper'

describe Event do
  it { is_expected.to validate_presence_of :subject_id }
  it { is_expected.to validate_presence_of :start_date }
  it { is_expected.to validate_presence_of :end_date }
  it { is_expected.to validate_presence_of :start_time }
  it { is_expected.to validate_presence_of :end_time }
  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of :every }
  it { is_expected.to validate_inclusion_of(:every).in_array(['month', 'week', 'day']) }
  it { is_expected.to belong_to :subject }
  it { is_expected.to have_one(:period).through(:subject) }

  it 'is invalid if start_date after end_date' do
    event = build(:event, start_date: '05-05-2015', end_date: '01-01-2015')
    expect(event).to be_invalid
  end

  it 'is invalid if start_time after end_time' do
    event = build(:event, start_time: '12:00', end_time: '10:00')
    expect(event).to be_invalid
  end

  it 'gets every date of ocurrence of the event weekly' do
    event = build(:event)
    expect(event.dates).to eq([Date.new(2015, 8, 10), Date.new(2015, 8, 17)])
  end

  it 'gets every date of ocurrence of the event yearly' do
    event = build(:event, every: 'year')
    expect(event.dates).to eq([Date.new(2015, 8, 10)])
  end

  it 'gets every date of ocurrence of the event daily' do
    event = build(:event, every: 'day', end_date: '2015-08-11')
    expect(event.dates).to eq([Date.new(2015, 8, 10), Date.new(2015, 8, 11)])
  end

  it 'raises error if every value not valid' do
    event = build(:event, every: 'decade')
    expect { event.dates }.to raise_error('valor nao suportado: decade')
  end

  it 'converts a date and time into a datetime' do
    event = create(:event, subject_id: 1, start_date: '01-01-2015', start_time: '10:00')
    expect(Event.format_datetime(event.dates[0], event.start_time)).to eq(DateTime.new(2015, 1, 1, 10, 0, 0))
  end

  it 'converts an event ocurrences to a JSON' do
    event = build(:event)
    dates = [{ id: event.id, title: event.title, start: DateTime.new(2015, 8, 10, 10, 0, 0), end: DateTime.new(2015, 8, 10, 12, 0, 0) }, { id: event.id, title: event.title, start: DateTime.new(2015, 8, 17, 10, 0, 0), end: DateTime.new(2015, 8, 17, 12, 0, 0) }]

    expect(event.fullcalendar_conversion).to eq(dates)
  end

  it 'sets event params that depends on its period or subject' do
    period = create(:period, id: 1)
    subject = create(:subject, id: 1, period_id: 1)
    event = create(:event, subject_id: 1)
    manual_event = event
    event = event.by_date(period, subject)
    manual_event.title = subject.name
    manual_event.start_date = period.start_date + ((manual_event.weekday.to_i - period.start_date.wday) % 7)
    manual_event.end_date = period.end_date
    manual_event.fullcalendar_dates = manual_event.fullcalendar_conversion
    expect(event).to eq(manual_event)
    # expect(event.title).to eq(subject.name)
    # expect(event.start_date).to eq(period.start_date + ((event.weekday.to_i - period.start_date.wday) % 7))
    # expect(event.end_date).to eq(period.end_date)
    # expect(event.fullcalendar_dates).to eq(event.fullcalendar_conversion)
  end
end
