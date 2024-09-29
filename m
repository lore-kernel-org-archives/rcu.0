Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBED918622;
	Sun, 29 Sep 2024 00:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727569224; cv=none; b=auaLqElmHbqXWHqiVF3XfSBIj4FXG5mtKu8OfZxU4mY0/NheAUxqEEQ1UPQCBgz72NJQ2JJNrJs2Lcjk7YoKcghCzyxrLoDhCfGSC88na7A1+3ORCnPYBckNZWPn3ThtDs5eK8Rp1bUX+EgLloM+8buIRMIqfzx3XaE8M4SwKCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727569224; c=relaxed/simple;
	bh=Q9NKGA9e8SpsBeHRGYpOWyq1+YIDZCPIRoH/v9mX76Q=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=GJurvDrOreuanwilTxNUiydeUpe0MZNGyMknIB9O5cr304kjfok4kBOYFtP10mOFFnOmZwCjLIOSv45kKsc+EJFsyMSJgJbXlXMQMr1/zOuSxBzl18HkFx4UVQ+NkoVRdCeK8K4wN5tiBCMiLu8V5pJdrUq4SgI5V2PRqKcGewU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BHdfrHcf; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHdfrHcf"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71971d2099cso2630298b3a.2;
        Sat, 28 Sep 2024 17:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727569222; x=1728174022; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AciA5lkArq2LcuAgiidbmpLX8//NU2EZPXWMWey1klw=;
        b=BHdfrHcfNpWDhIDQe0+Z9HOvc4bH6PA4azOhFArlMKbPW/gbXn5HuczycXYLiiU2gA
         pb3gYistZH5BMEQL5Ii6oZhszrM2cbHQk6hD1Dhu6F1CD2T/tN3VNbtBeCQ09vfCJXLr
         ztiWHjPjjMValXyzqN7NJAHcYmLuBtLhmEAlMczqoGz5TwX7vTtcsY22aQw9xIPqbIMf
         0qTYzLA6J+Qvg46ZR7Z73r6RAxXEzPTPHMeO7H5TOWvDJqYv3ru5QiZ8cZP1zks+jaeo
         gar3t15Vvh83Ofc03V7XqUEVP+YQ3ZioTu5VAu/S+kqPiTUxPuJ1D6toQBRe8GJd9oRB
         NZOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727569222; x=1728174022;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AciA5lkArq2LcuAgiidbmpLX8//NU2EZPXWMWey1klw=;
        b=I3q1TQEHuR7Q64BmTdo9dQIG+rfgfCzDWmY8tZbpOEuB55EbOOgsVXRgKcbf9gw9Lg
         v+WHrT6jj8wgM45y307kg3acq6lQAbZPApVLIgqVKYH9UNtofLhGhKAOzQkTjVLoJR32
         PyIlJCvJYUYgBtE0XUP75ngxbBegw5r0VRxRzaRbNBIkjUldL3cAxD/nW2kzuyqEhfqR
         3m/Gbd23QjXTYRCv4aNUpJtP2sgGgTORnY+kVYmwMPHj6WBaLz3MzQhYGkySiVzvcbxh
         AHkhn7Da5ik7+9q8HfvPci6WF/Xob77gu8Snmw1NId3VUlJOiq2V0HQWqnWXhVdeYyhw
         RlQA==
X-Forwarded-Encrypted: i=1; AJvYcCU/IvkXIyN45aPZpICPX1neMr9Auq6/DKsssoW+WovPzsp8Stj+aFOVeFWMUNLZ9uE/aRbqpQxGro9oOBM=@vger.kernel.org, AJvYcCXtI4P6dM8qcm1FzYLCyU7kATDSwXY2Sdu1fqRXtbo+srdp2hDZXiZsRWlLJ/GOYoLOv1K/@vger.kernel.org
X-Gm-Message-State: AOJu0YzW6poremw4mCcmrTnmDjO4S/5tinBKdXC4uLcZOwuBj+XnUhLS
	PrR0G8HKoc9hVzVKRZPzZuGysvM78/V0QMklBgZxMdqHQjvHU1NB
X-Google-Smtp-Source: AGHT+IGrPCIsZd3xVlDfQ3t7v5wWjb0n8Dw8h91/C6QpaBBBIkYhcxX80aGJo1MfszwJ4cOHtuUW3Q==
X-Received: by 2002:a05:6a00:194f:b0:717:e01d:312f with SMTP id d2e1a72fcca58-71b26078cf5mr12778522b3a.27.1727569221947;
        Sat, 28 Sep 2024 17:20:21 -0700 (PDT)
Received: from smtpclient.apple ([2402:d0c0:11:86::1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6db2b390dsm3889001a12.20.2024.09.28.17.20.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Sep 2024 17:20:21 -0700 (PDT)
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
In-Reply-To: <60123be5-ae24-4426-b9ca-6f39e64ab76b@app.fastmail.com>
Date: Sun, 29 Sep 2024 08:20:01 +0800
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Alan Stern <stern@rowland.harvard.edu>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Will Deacon <will@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 John Stultz <jstultz@google.com>,
 Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>,
 "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
 rostedt <rostedt@goodmis.org>,
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
 Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
 RCU <rcu@vger.kernel.org>,
 linux-mm@kvack.org,
 lkmm@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <BD97A93F-EAFC-4C32-97F8-EEC8C1B48519@gmail.com>
References: <20240928135128.991110-1-mathieu.desnoyers@efficios.com>
 <20240928135128.991110-2-mathieu.desnoyers@efficios.com>
 <02c63e79-ec8c-4d6a-9fcf-75f0e67ea242@rowland.harvard.edu>
 <2091628c-2d96-4492-99d9-0f6a61b08d1d@efficios.com>
 <d2c87672-af75-4210-bd96-d7f38f2f63ac@rowland.harvard.edu>
 <d49f5d9f-559d-449b-b330-9e5a57d9b438@efficios.com>
 <D31AF4E7-B9D5-4D2F-A4B9-1E12B5E69549@gmail.com>
 <60123be5-ae24-4426-b9ca-6f39e64ab76b@app.fastmail.com>
To: Boqun Feng <boqun.feng@gmail.com>
X-Mailer: Apple Mail (2.3776.700.51)

2024=E5=B9=B49=E6=9C=8829=E6=97=A5 07:55=EF=BC=8CBoqun Feng =
<boqun.feng@gmail.com> wrote=EF=BC=9A
>=20
>=20
>=20
> On Sun, Sep 29, 2024, at 6:26 AM, Alan Huang wrote:
>> 2024=E5=B9=B49=E6=9C=8828=E6=97=A5 23:55=EF=BC=8CMathieu Desnoyers =
<mathieu.desnoyers@efficios.com> wrote=EF=BC=9A
>>>=20
>>> On 2024-09-28 17:49, Alan Stern wrote:
>>>> On Sat, Sep 28, 2024 at 11:32:18AM -0400, Mathieu Desnoyers wrote:
>>>>> On 2024-09-28 16:49, Alan Stern wrote:
>>>>>> On Sat, Sep 28, 2024 at 09:51:27AM -0400, Mathieu Desnoyers =
wrote:
>>>>>>> equality, which does not preserve address dependencies and =
allows the
>>>>>>> following misordering speculations:
>>>>>>>=20
>>>>>>> - If @b is a constant, the compiler can issue the loads which =
depend
>>>>>>>   on @a before loading @a.
>>>>>>> - If @b is a register populated by a prior load, weakly-ordered
>>>>>>>   CPUs can speculate loads which depend on @a before loading @a.
>>>>>>=20
>>>>>> It shouldn't matter whether @a and @b are constants, registers, =
or
>>>>>> anything else.  All that matters is that the compiler uses the =
wrong
>>>>>> one, which allows weakly ordered CPUs to speculate loads you =
wouldn't
>>>>>> expect it to, based on the source code alone.
>>>>>=20
>>>>> I only partially agree here.
>>>>>=20
>>>>> On weakly-ordered architectures, indeed we don't care whether the
>>>>> issue is caused by the compiler reordering the code (constant)
>>>>> or the CPU speculating the load (registers).
>>>>>=20
>>>>> However, on strongly-ordered architectures, AFAIU, only the =
constant
>>>>> case is problematic (compiler reordering the dependent load), =
because
>>>> I thought you were trying to prevent the compiler from using one =
pointer
>>>> instead of the other, not trying to prevent it from reordering =
anything.
>>>> Isn't this the point the documentation wants to get across when it =
says
>>>> that comparing pointers can be dangerous?
>>>=20
>>> The motivation for introducing ptr_eq() is indeed because the
>>> compiler barrier is not sufficient to prevent the compiler from
>>> using one pointer instead of the other.
>>=20
>> barrier_data(&b) prevents that.
>>=20
>=20
> It prevents that because it acts as barrier() + OPTIMIZER_HIDE_VAR(b).
> I don=E2=80=99t see much value of using that since we can resolve the =
problem
> with OPTIMIZER_HIDE_VAR() alone.

Yeah, barrier_data generates more instructions.

>=20
> Regards,
> Boqun
>=20
>>>=20
>>> But it turns out that ptr_eq() is also a good tool to prevent the
>>> compiler from reordering loads in case where the comparison is
>>> done against a constant.
>>>=20
>>>>> CPU speculating the loads across the control dependency is not an
>>>>> issue.
>>>>>=20
>>>>> So am I tempted to keep examples that clearly state whether
>>>>> the issue is caused by compiler reordering instructions, or by
>>>>> CPU speculation.
>>>> Isn't it true that on strongly ordered CPUs, a compiler barrier is
>>>> sufficient to prevent the rcu_dereference() problem?  So the whole =
idea
>>>> behind ptr_eq() is that it prevents the problem on all CPUs.
>>>=20
>>> Correct. But given that we have ptr_eq(), it's good to show how it
>>> equally prevents the compiler from reordering address-dependent =
loads
>>> (comparison with constant) *and* prevents the compiler from using
>>> one pointer rather than the other (comparison between two =
non-constant
>>> pointers) which affects speculation on weakly-ordered CPUs.
>>>=20
>>>> You can make your examples as specific as you like, but the fact =
remains
>>>> that ptr_eq() is meant to prevent situations where both:
>>>> The compiler uses the wrong pointer for a load, and
>>>> The CPU performs the load earlier than you want.
>>>> If either one of those doesn't hold then the problem won't arise.
>>>=20
>>> Correct.
>>>=20
>>> Thanks,
>>>=20
>>> Mathieu
>>>=20
>>>=20
>>> --=20
>>> Mathieu Desnoyers
>>> EfficiOS Inc.
>>> https://www.efficios.com


