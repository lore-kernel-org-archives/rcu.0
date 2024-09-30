Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B95314E2E8;
	Mon, 30 Sep 2024 09:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727688487; cv=none; b=UJFdcaXgDv+zgnYJm2tFQMP6mvXB2mkpDaeLcRg8ggmBDrZC8nYSXe7CU13aD6jAREKJXtfpowBEBRqldE2WaqPMmcGo+lOyhz6/LMEBwDk+gvCFgBrZrvpnbkhNo4i0aoL4mEWEhBTwPpHtk1wOiiawrBa9zGNhPENExCzq3eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727688487; c=relaxed/simple;
	bh=/Y/WvIG5HM8QB3Mef/wYZC810KU9XO+QwbXNzClpnfs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=AwpPHYXwSgQmpVuD93MASpiUiw6OjwH1EAq+oqc7YJ5kUEtQvqU0UI+sEXfQTL0JfTzZH7Jzutl0izzBzxzpcSql3sVMALQWelJk6QGGfPtLkkSMyNa3KgBe9i40sv0Vicfq/cllmin7jjyeEYSzfdyieOyoD8uYmUDmShyjE80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UuTJuT6S; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuTJuT6S"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2059204f448so35211995ad.0;
        Mon, 30 Sep 2024 02:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727688485; x=1728293285; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z059m6JExv5qpwK4TrSHM55XYy4d2Mm8ALddHKMFxag=;
        b=UuTJuT6SP3bhHKGfADEipTV08D3ODchp5C/0A4DW4xjhxQw8H0YGF9Kn69oxGUYklM
         WINczsrrLscX6PtcpxCbwl2rqlYepFkZn1yFEWdEOWVXst9jNOLII7cDIZ9CGKK9Ry/w
         Xh2hrFBGNWOMGxWOrLuQJMQfzZHD6a2bYoGUJRJso23fU2e6xlBW9hJImkDFXadTi8Nk
         qTP9VEktPSrf6M3APXjINk2atkedefVNK2lW6aexqvVsnHCk62vFD+lpvMrD1hFZg3vh
         n4KSnRZJuFgHaI9IZZKO4qtu2y7frreVI86jCry42sl+Q6m2mH7xqZFmk2qR4ym/+ywo
         UC0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727688485; x=1728293285;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z059m6JExv5qpwK4TrSHM55XYy4d2Mm8ALddHKMFxag=;
        b=wxJWI32V83arQId9vbqJPCFSglDAOSC3JV7Uwfs6i2x+SIcdVqf21Lwr+0lhD6a117
         qO3ued/5NnAdYKm+OQ2fOjUWOKwYL/v8TdG2qbLdkYmjSC7ArYrEm6tQpu50QWbWGe7t
         TibVOB/QUdYgXRIkvRPD62tVRSaxLmAqRGK+M/DzyEXwJYmA3ICOs3YVix8BRBlzlqrx
         ++n1BrdFC9ng8UVttBwmPxq0KaWNBz9RQ5lkv9CSn3ORPGkrOYG0jscMC3TwiLQM5NBe
         Hvpq4qP8gkdqyWfirLu6TZYQ7ZH9NrkWLRBy0vRC46mOHR2SVAVA+zoUbdN5yfOUzMLQ
         GB6g==
X-Forwarded-Encrypted: i=1; AJvYcCV+v+VlNOa/emTGggQs93gKx+Gtz9AXsnOzur2YXD7wWxBfJD/Y3WYGU8cr+gBKFf7bOUj+pU/2mFaT5DY=@vger.kernel.org, AJvYcCVLyNcD/4EsRIzkEYO9nDHvI8GJRF1J41zv5KBtRO/tMRuUCo3jTkyzcYR0a3BS+Qgm2o7w@vger.kernel.org
X-Gm-Message-State: AOJu0YxCD4piVA4kn+FFIgmlyNqgeZbOyLZIDTt3i7LaudtwnDyRBRTg
	C13MyD+A2oJTj4mmczJmdN+scSV4BipTjj5KaOVWPdGCpv6S3c+d
X-Google-Smtp-Source: AGHT+IFEpUA9lBz28DWCV9NGf0oBtIqIPy4MpNVYCvzKykDQJRwefTC7jlNkxWq5imCATpncdx/8Kg==
X-Received: by 2002:a17:90a:a58e:b0:2e0:808f:ef9e with SMTP id 98e67ed59e1d1-2e0b8ec8cebmr13138814a91.26.1727688484625;
        Mon, 30 Sep 2024 02:28:04 -0700 (PDT)
Received: from smtpclient.apple ([2402:d0c0:11:86::1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e05b57decdsm13371449a91.1.2024.09.30.02.27.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Sep 2024 02:28:04 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH 1/2] compiler.h: Introduce ptr_eq() to preserve address
 dependency
From: Alan Huang <mmpgouride@gmail.com>
In-Reply-To: <EEAE4623-DCD7-4BBE-8E06-7F6FF6E3070B@gmail.com>
Date: Mon, 30 Sep 2024 17:27:45 +0800
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Alan Stern <stern@rowland.harvard.edu>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Will Deacon <will@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 John Stultz <jstultz@google.com>,
 Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>,
 "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang1211@gmail.com>,
 Ingo Molnar <mingo@redhat.com>,
 Waiman Long <longman@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>,
 maged.michael@gmail.com,
 Mateusz Guzik <mjguzik@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 RCU <rcu@vger.kernel.org>,
 linux-mm@kvack.org,
 lkmm@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <E2551572-494D-46A0-A1D5-DF91DDB8B9F9@gmail.com>
References: <20240928135128.991110-1-mathieu.desnoyers@efficios.com>
 <20240928135128.991110-2-mathieu.desnoyers@efficios.com>
 <02c63e79-ec8c-4d6a-9fcf-75f0e67ea242@rowland.harvard.edu>
 <2091628c-2d96-4492-99d9-0f6a61b08d1d@efficios.com>
 <d2c87672-af75-4210-bd96-d7f38f2f63ac@rowland.harvard.edu>
 <d49f5d9f-559d-449b-b330-9e5a57d9b438@efficios.com>
 <D31AF4E7-B9D5-4D2F-A4B9-1E12B5E69549@gmail.com>
 <8d20cf79-9fa5-4ced-aa91-232ccd545b59@huaweicloud.com>
 <EEAE4623-DCD7-4BBE-8E06-7F6FF6E3070B@gmail.com>
To: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
X-Mailer: Apple Mail (2.3776.700.51)

2024=E5=B9=B49=E6=9C=8830=E6=97=A5 17:15=EF=BC=8CAlan Huang =
<mmpgouride@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> 2024=E5=B9=B49=E6=9C=8830=E6=97=A5 16:57=EF=BC=8CJonas Oberhauser =
<jonas.oberhauser@huaweicloud.com> =E5=86=99=E9=81=93=EF=BC=9A
>>=20
>>=20
>>=20
>> Am 9/29/2024 um 12:26 AM schrieb Alan Huang:
>>> 2024=E5=B9=B49=E6=9C=8828=E6=97=A5 23:55=EF=BC=8CMathieu Desnoyers =
<mathieu.desnoyers@efficios.com> wrote=EF=BC=9A
>>>>=20
>>>> On 2024-09-28 17:49, Alan Stern wrote:
>>>>> On Sat, Sep 28, 2024 at 11:32:18AM -0400, Mathieu Desnoyers wrote:
>>>>>> On 2024-09-28 16:49, Alan Stern wrote:
>>>>>>> On Sat, Sep 28, 2024 at 09:51:27AM -0400, Mathieu Desnoyers =
wrote:
>>>>>>>> equality, which does not preserve address dependencies and =
allows the
>>>>>>>> following misordering speculations:
>>>>>>>>=20
>>>>>>>> - If @b is a constant, the compiler can issue the loads which =
depend
>>>>>>>>   on @a before loading @a.
>>>>>>>> - If @b is a register populated by a prior load, weakly-ordered
>>>>>>>>   CPUs can speculate loads which depend on @a before loading =
@a.
>>>>>>>=20
>>>>>>> It shouldn't matter whether @a and @b are constants, registers, =
or
>>>>>>> anything else.  All that matters is that the compiler uses the =
wrong
>>>>>>> one, which allows weakly ordered CPUs to speculate loads you =
wouldn't
>>>>>>> expect it to, based on the source code alone.
>>>>>>=20
>>>>>> I only partially agree here.
>>>>>>=20
>>>>>> On weakly-ordered architectures, indeed we don't care whether the
>>>>>> issue is caused by the compiler reordering the code (constant)
>>>>>> or the CPU speculating the load (registers).
>>>>>>=20
>>>>>> However, on strongly-ordered architectures, AFAIU, only the =
constant
>>>>>> case is problematic (compiler reordering the dependent load), =
because
>>>>> I thought you were trying to prevent the compiler from using one =
pointer
>>>>> instead of the other, not trying to prevent it from reordering =
anything.
>>>>> Isn't this the point the documentation wants to get across when it =
says
>>>>> that comparing pointers can be dangerous?
>>>>=20
>>>> The motivation for introducing ptr_eq() is indeed because the
>>>> compiler barrier is not sufficient to prevent the compiler from
>>>> using one pointer instead of the other.
>>> barrier_data(&b) prevents that.
>>=20
>> I don't think one barrier_data can garantuee preventing this, because =
right after doing the comparison, the compiler still could do b=3Da.
>>=20
>> In that case you would be guaranteed to use the value in b, but that =
value is not the value loaded into b originally but rather the value =
loaded into a, and hence your address dependency goes to the wrong load =
still.
>=20
> After barrier_data(&b), *b will be loaded from memory, you mean even =
if *b is loaded from memory, the address dependency goes to the wrong =
load still?

Sorry, *b should b.

>=20
>>=20
>> However, doing
>>=20
>> barrier_data(&b);
>> if (a =3D=3D b) {
>>  barrier();
>>  foo(*b);
>> }
>>=20
>> might maybe prevent it, because after the address of b is escaped, =
the compiler might no longer be allowed to just do b=3Da;, but I'm not =
sure if that is completely correct, since the compiler knows b=3D=3Da =
and no other thread can be concurrently modifying a or b. Therefore, =
given that the compiler knows the hardware, it might know that assigning =
b=3Da would not cause any  race-related issues even if another thread =
was reading b concurrently.
>>=20
>> Finally, it may be only a combination of barrier_data and making b =
volatile could be guaranteed to solve the issue, but the code will be =
very obscure compared to using ptr_eq.
>>=20
>> jonas


