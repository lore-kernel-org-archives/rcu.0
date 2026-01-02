Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2A82FAC12
	for <rcu@vger.kernel.org>; Fri,  2 Jan 2026 17:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767376703; cv=none; b=Q+IzBXfjF3oMugI2cKa86kimGyxz//JUVa+C/mjdJXj12fHXDJ9KJ/fBGevUdhCV08eE7zPR0IN7jB3JQe5VyzrdwRs9qFKzx3iJG0u5udkAAd9tV7MlTxoKkaVKaejHzHM42XPIZ1wP2kjHFrwO0SzHI/j0Xa0dJaBR05O/Xag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767376703; c=relaxed/simple;
	bh=ePf4jYh+s42UWlrd9/NgbZEw9hUakBt4V+4l69b6AHs=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=CSt/TGIHeqJKA8dQ2iqMdd08qsbqKmATr5ZEY2Lzo/ZfQ0vnou2xp0mmZnhUa6ecqb7K97h7YCYvz+R4pjp862cq/2QAFVT7u6M6gdmbrnWAsqiDwEPSQGl4V2UBb5FqKPXWfbwbKPwLa/mabPDgLsw1IOwS3tOANApqisvEG74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=RiRYdkLG; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="RiRYdkLG"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8c0f13e4424so1079744885a.1
        for <rcu@vger.kernel.org>; Fri, 02 Jan 2026 09:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1767376701; x=1767981501; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=USCxNGUMtzSyDP5Fc9MpwmREouX+A44qtoiXszdYOig=;
        b=RiRYdkLG5yZit6npOL4QZ5izPuuR/a9F0LfC8ip0daxnz0e7OQdINAP9Zr1clvL9vB
         Px7wzxW/6kKeELAEkPqfN2A8MvZmYgWJvonM+pABWsG2mEok+t8+ZCsgNFb+s12172M7
         88MjdDnJpcG8vUooywlcOIysjx8dVYcP/ndAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767376701; x=1767981501;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=USCxNGUMtzSyDP5Fc9MpwmREouX+A44qtoiXszdYOig=;
        b=EpbTIm1il/tYea7qsCuZHYvVh/tOtps15d7i0lf92ekBZUmJJKrIov+RncShOn99J0
         KD7mzrdr6eN9y822X25pffkoVZZo0qKhlMVo2pon92f+RXSSfy55DbTYSycbHT70x+05
         rpq7X21kUMKQ/EPtNtxOOH6IpeToqJZKM4bWXfKJLu5KfWbunHh+hutZdGE6too5vUqM
         JoM4QT90dWa5Npt7ovM4jXKnslmRndgxplWoA43f6fwJLlRfermMvUy9f/kr7LGWl1Uw
         8lXxpXH7tjRZF1pbkq7h+NM1sIjZgysEAMPTtk35e+thxynxNUF/atVQJSFnUEwzKczW
         8gYw==
X-Forwarded-Encrypted: i=1; AJvYcCWqmYmEcBl+e0aF5hlhrb+0HOU+Gv7e1NvAnM3VruHXVcBzgiHqNputIM68OtTH+qXCzEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI3leZiy0vKm6zBWbUAH/USE9rl+tOnwCbxvAO7gkF/W2Hh2NV
	55Xm7A6VigAdkVPxmZrsJHzroibExlDR2VRizaV/UuxmAQgYHkl2+WF63V8SnXrqo/Y=
X-Gm-Gg: AY/fxX6rsBZpgRZtp0zsjd152AKsDYs3/50H6i63LvZHNvhkMRsTD2KQHD1o9yfXG/l
	xy5fy21bWYBW+YogbYjzgScouKEFfiXs15LXZ6WIrQXaGei68PpXLQdTDkf0+Ew+SHVSCKpi5/c
	/UoOvEtqO1BdX1thklht6Gn+7K2RmU8rbdCfTNrkGZqducarjOcOuV88zfovYeXSefqRJPkGtvX
	vwSI6tVGYy7kflzhowy7aL57tCq6YmvSxdRmiOdLcInmwj3RY/meZ1nxCM6SRom2KlrDX/lCh/2
	oxwTtDlw+d1vHi4dSVQu+MA5McRiGT4aXvwQ9pKz0Y16tqFx0Bab5itwGNzQg0cMkIkm7APmZNQ
	YrI+70fefSvJVosYTmInV4jaLkWoGEiNZGULwQYa7vN/RgGuo7SYw4yULCQ0pF/JdIv4n6eXtHW
	6ipueZreRNHRVA/pzFx4GJTpZm9ZTPbuC/sWQK/G4oEeFcmFk=
X-Google-Smtp-Source: AGHT+IFQIm1GtYBU5JRPSAmGrACvGnj35KrORfuzomyrgDtEakQJtZEPrKsxGIcMUk4MUcGRpm5eSw==
X-Received: by 2002:a05:620a:691a:b0:8b2:e5da:d316 with SMTP id af79cd13be357-8c090707070mr6243144585a.87.1767376700870;
        Fri, 02 Jan 2026 09:58:20 -0800 (PST)
Received: from smtpclient.apple ([2607:fb90:b3ad:c4fd:45bb:762f:48db:e855])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d9aa3ac8fsm302884746d6.56.2026.01.02.09.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 09:58:20 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Joel Fernandes <joel@joelfernandes.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC] jiffies_till_first_fqs off by 1
Date: Fri, 2 Jan 2026 12:58:08 -0500
Message-Id: <3D3F17CD-C7EC-44B1-85E2-95022BBDB55E@joelfernandes.org>
References: <e6ec0a2e-aadd-43fc-b54c-063926c39734@paulmck-laptop>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, rcu <rcu@vger.kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 Davidlohr Bueso <dave@stgolabs.net>, Josh Triplett <josh@joshtriplett.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>
In-Reply-To: <e6ec0a2e-aadd-43fc-b54c-063926c39734@paulmck-laptop>
To: paulmck@kernel.org
X-Mailer: iPhone Mail (23B85)



> On Jan 1, 2026, at 10:41=E2=80=AFPM, Paul E. McKenney <paulmck@kernel.org>=
 wrote:
>=20
> =EF=BB=BFOn Thu, Jan 01, 2026 at 09:59:27PM -0500, Joel Fernandes wrote:
>>=20
>>=20
>>> On 1/1/2026 5:24 PM, Paul E. McKenney wrote:
>>> On Thu, Dec 25, 2025 at 09:15:59PM -0500, Joel Fernandes wrote:
>>>> On Thu, Dec 25, 2025 at 10:54:20AM -0800, Paul E. McKenney wrote:
>>>>> On Tue, Dec 23, 2025 at 09:06:19PM -0500, Joel Fernandes wrote:
>>>>>> Hi Paul,
>>>>>>=20
>>>>>> On Tue, Dec 23, 2025 at 03:53:23PM -0800, Paul E. McKenney wrote:
>>>>>>> On Tue, Dec 23, 2025 at 12:38:19PM -0500, Joel Fernandes wrote:
>>>>>>>> During studying some synchronize_rcu() latencies, I found that the
>>>>>>>> jiffies_till_first_fqs value passed to the timer tick subsystem doe=
s is always
>>>>>>>> off by one. This is natural due to calc_index() rounding up.
>>>>>>>>=20
>>>>>>>> For example, jiffies_till_first_fqs=3D3 means the "Jiffies till fir=
st FQS" delay
>>>>>>>> is actually 4ms. And same for the next FQS. In fact, in testing it s=
hows it can
>>>>>>>> never ever be 3ms for HZ=3D1000. And in rare cases, it will go to 5=
ms probably due
>>>>>>>> to interrupts.
>>>>>>>>=20
>>>>>>>> Considering this, I think it is better to reduce the jiffies_till_f=
irst_fqs by 1
>>>>>>>> before passing it to the wait APIs.
>>>>>>>>=20
>>>>>>>> But before I wanted to send a patch, I wanted to get everyone's tho=
ughts.
>>>>>>>> Considering this the RFC.
>>>>>>>=20
>>>>>>> Inadvertent passing of the value zero?
>>>>>>=20
>>>>>> This should not be an issue because at the moment, even a value of
>>>>>> jiffies_till_first_fqs =3D=3D 0 waits for ~1 jiffie due to schedule_t=
imeout(0).
>>>>>>=20
>>>>>> But you raise a good point, we should cap the minimum allowed jiffie v=
alue
>>>>>> for the fqs parameters to 1 so that we don't pass schedule_timeout() w=
ith
>>>>>> negative values when/if we do the reduce-by-one approach.
>>>>>=20
>>>>> There is a potential use case for jiffies_till_first_fqs=3D0 and no wa=
it,
>>>>> which would be systems that want to scan for idle CPUs immediately aft=
er
>>>>> the grace period has been initialized.  Note the word "potential".  ;-=
)
>>>>=20
>>>> Sure, we could add support for that but that would be new behavior that=
 is
>>>> not in the existing code.
>>>>=20
>>>> So jiffies_till_first_fqs=3D0 today, I think it is not 'working as inte=
nded'
>>>> because it will never not wait I think.
>>>=20
>>> Agreed.
>>>>> So we should fix that too? Or maybe it can be a patch separate from th=
is
>>>> (that I can work on). I think no harming in allowing that mode, at leas=
t it
>>>> will be more in line with the expected outcome.
>>>=20
>>> Makes sense!  However, given that no one has complained, care is require=
d.
>>> Someone might be relying on the old behavior.  (In which case an easy
>>> fix would be to make -1 be no waiting, though one might hope for a
>>> better fix.)
>> Some further investigations revealed that the "1 jiffie error" is actuall=
y worst
>> case. In the best case, it could still be closer to a jiffie. It is just t=
he
>> nature of the timer wheel, since it snaps to numerical TICK_NS boundary, t=
he
>> rounding error is intentionally added depending on how far along in the b=
oundary
>> was the timer for the wait enqueued. If we took probability distributions=
, we
>> should be landing with a 1/2 jiffie error, though in practice I've seen i=
t to be
>> 3/4 jiffie error on average.
>>=20
>> Given this, it would probably not make sense for us to do the -1 to adjus=
t for
>> the error (since we don't clearly have bounds on the minimum error). We j=
ust
>> have to accept that we'd lose 1-2 extra jiffie per FQS loop iteration wai=
t,
>> which is amplified if a grace period is already in progress. I've seen th=
is add
>> upto 4 jiffies to back-to-back synchronize_rcu() latency even when there a=
re no
>> readers in progress.
> .
>> But I had to go down the rabbit hole and check... ;-)
>=20
> I was thinking in terms of special-casing -1 to skip the sleep, but I
> guess that there are as many ways to skin a rabbit as a cat.  ;-)

Sure I am happy to do that. One of my fears though is no one will know to us=
e it that way making it not that useful.

Do let me know if anyone sets it to 0 though. Perhaps for testing even to ma=
ke the GP cycle shorter?

 - Joel


>=20
>                            Thanx, Paul
>=20
>=20
