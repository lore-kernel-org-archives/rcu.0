Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8638915C139;
	Sat, 28 Sep 2024 22:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727562427; cv=none; b=VKiAK4veRqfRITwD8BqpQFACZwL+XDJ3h1KETN/j7kyKzXPAfhDmeZcGsw9GukM8QNmjULXF+fGlovJ/FKDpPHqqoEyKXmEuOXmU6nE3xdbhiwva2hwJ1qwSVSW3C9QVdyAX1Z9hxJk2izM2ejZhkrG8ZWiTnto2zKbEGYuzX9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727562427; c=relaxed/simple;
	bh=iT+lEwf1Yp1LuoaQLOYzlAsb/T1uUnPPqijfxDwh6hE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=D8IMIqp0nadGQlKHCb7FgOHVIBAk0PzJziD7WlQ+EOg+yYupL/D5g1Jd+0B6AUHPqnLrGUPGldHqq0iiTvz2wyQ1lwVOHMLHQ9mYIjiddV7PNIFc/KaCW0ugP9SgGyyTteEcosJ0RB8AW10ev7CYCjo2IoKaB4UMoZgbH9PnKWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ELfUgilK; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELfUgilK"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7db238d07b3so2715400a12.2;
        Sat, 28 Sep 2024 15:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727562425; x=1728167225; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=39TwabcFKO8PAh5Fmj4zbLOsgDGHvVg85M19XMWn6GI=;
        b=ELfUgilK8IlxOHzgzvhpQg5/NmZiAleN/IlzakE3hv16F1xm0YIjOfx5G7nlb+MN0G
         jWjkIx12ZqEB0IUNZh7sNGv+Y2AdlEpU5FSpOKDMiu14Nxwi+1aqNJO2D5kE2EM/Q2wx
         7wlmb6in9Tduylgf+WPh9iBTXuj7h16sNRu6LARMe7ddlv0BHrNmCoXjFG6I3Kac9nQ0
         qZFzVVwRbdKu+/Q/8lmdZZymsK+/D424SApatmV6ExNo9jK+YxJm/jLAgPdgTUrhTZxx
         7bxbMdWGplQNT0x4LCmPqCNlO/VzdE0ZP/YOEryjXXivaaK0mCpKsSr+7ECb77GjyX68
         mgfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727562425; x=1728167225;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=39TwabcFKO8PAh5Fmj4zbLOsgDGHvVg85M19XMWn6GI=;
        b=ZK2k2zaA+JH6TaKvoBf7fZEHKDmZD8WU5Hi+oCFsmvixxieKCDKsp28wAW6Jr6Lbyz
         N/Od2966ciWPVKWwQDpGmIaUGuSOdcqaS/87h5ac+1ni0hTkj8WzRRV+FrWjYADTpwnr
         BIUanc/DsBhPyMnjEb2nZOv8EfBvrh4NzeYdBgTRFAYm9qFVBQYV95bm8FMLW7TmfGcz
         ULxLniGGVKhL1rTIL+D6Ng1MTWFhi3iL92x31mVIJ6e3H7DXIpxjXtVBOQyAeJ+7J65Z
         ZLloNmyXmLAEjI5yRB8VL95QW1He3meyHl70Dcy6lVMeLUbJjQS0664VBQ/u249CndOS
         Ypsg==
X-Forwarded-Encrypted: i=1; AJvYcCUNBWwNFS83Av//Unzj0Y6Rd7WatcyT61cBWQxMe/6YI8LnxiSpatT4x3gi7dRBbZT4TM49@vger.kernel.org, AJvYcCWRZFRM/rAGOzJ+KwDqB4kxVTRKN2UmGbrMmtxSMFLkbxgdJrRtvHsymkNRBcXT+EVEFumspL51enDPO00=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa5edDofvnoPUuOQhs/X2hP/wIQjDksJE3oJqJ33mh8OQ76T4r
	6ZyOtVgLgvGj1Z2750g2wCpm9oSb8RjbFrP4p2yupXDYF7aSc7RW
X-Google-Smtp-Source: AGHT+IHU++ItzZuI4JRlnnSPKUEq6zSjBveX5lFZ0ZRGbjdCCFJ3yEqulKfbG3mepSJoVqt/Zuzl+A==
X-Received: by 2002:a05:6a20:1b18:b0:1d3:ba1:18f4 with SMTP id adf61e73a8af0-1d4fa6c7bd2mr9103220637.26.1727562424750;
        Sat, 28 Sep 2024 15:27:04 -0700 (PDT)
Received: from smtpclient.apple ([2402:d0c0:11:86::1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6db2bce30sm3269533a12.38.2024.09.28.15.26.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Sep 2024 15:27:04 -0700 (PDT)
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
In-Reply-To: <d49f5d9f-559d-449b-b330-9e5a57d9b438@efficios.com>
Date: Sun, 29 Sep 2024 06:26:39 +0800
Cc: Alan Stern <stern@rowland.harvard.edu>,
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
 Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
 RCU <rcu@vger.kernel.org>,
 linux-mm@kvack.org,
 lkmm@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <D31AF4E7-B9D5-4D2F-A4B9-1E12B5E69549@gmail.com>
References: <20240928135128.991110-1-mathieu.desnoyers@efficios.com>
 <20240928135128.991110-2-mathieu.desnoyers@efficios.com>
 <02c63e79-ec8c-4d6a-9fcf-75f0e67ea242@rowland.harvard.edu>
 <2091628c-2d96-4492-99d9-0f6a61b08d1d@efficios.com>
 <d2c87672-af75-4210-bd96-d7f38f2f63ac@rowland.harvard.edu>
 <d49f5d9f-559d-449b-b330-9e5a57d9b438@efficios.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
X-Mailer: Apple Mail (2.3776.700.51)

2024=E5=B9=B49=E6=9C=8828=E6=97=A5 23:55=EF=BC=8CMathieu Desnoyers =
<mathieu.desnoyers@efficios.com> wrote=EF=BC=9A
>=20
> On 2024-09-28 17:49, Alan Stern wrote:
>> On Sat, Sep 28, 2024 at 11:32:18AM -0400, Mathieu Desnoyers wrote:
>>> On 2024-09-28 16:49, Alan Stern wrote:
>>>> On Sat, Sep 28, 2024 at 09:51:27AM -0400, Mathieu Desnoyers wrote:
>>>>> equality, which does not preserve address dependencies and allows =
the
>>>>> following misordering speculations:
>>>>>=20
>>>>> - If @b is a constant, the compiler can issue the loads which =
depend
>>>>>    on @a before loading @a.
>>>>> - If @b is a register populated by a prior load, weakly-ordered
>>>>>    CPUs can speculate loads which depend on @a before loading @a.
>>>>=20
>>>> It shouldn't matter whether @a and @b are constants, registers, or
>>>> anything else.  All that matters is that the compiler uses the =
wrong
>>>> one, which allows weakly ordered CPUs to speculate loads you =
wouldn't
>>>> expect it to, based on the source code alone.
>>>=20
>>> I only partially agree here.
>>>=20
>>> On weakly-ordered architectures, indeed we don't care whether the
>>> issue is caused by the compiler reordering the code (constant)
>>> or the CPU speculating the load (registers).
>>>=20
>>> However, on strongly-ordered architectures, AFAIU, only the constant
>>> case is problematic (compiler reordering the dependent load), =
because
>> I thought you were trying to prevent the compiler from using one =
pointer
>> instead of the other, not trying to prevent it from reordering =
anything.
>> Isn't this the point the documentation wants to get across when it =
says
>> that comparing pointers can be dangerous?
>=20
> The motivation for introducing ptr_eq() is indeed because the
> compiler barrier is not sufficient to prevent the compiler from
> using one pointer instead of the other.

barrier_data(&b) prevents that.

>=20
> But it turns out that ptr_eq() is also a good tool to prevent the
> compiler from reordering loads in case where the comparison is
> done against a constant.
>=20
>>> CPU speculating the loads across the control dependency is not an
>>> issue.
>>>=20
>>> So am I tempted to keep examples that clearly state whether
>>> the issue is caused by compiler reordering instructions, or by
>>> CPU speculation.
>> Isn't it true that on strongly ordered CPUs, a compiler barrier is
>> sufficient to prevent the rcu_dereference() problem?  So the whole =
idea
>> behind ptr_eq() is that it prevents the problem on all CPUs.
>=20
> Correct. But given that we have ptr_eq(), it's good to show how it
> equally prevents the compiler from reordering address-dependent loads
> (comparison with constant) *and* prevents the compiler from using
> one pointer rather than the other (comparison between two non-constant
> pointers) which affects speculation on weakly-ordered CPUs.
>=20
>> You can make your examples as specific as you like, but the fact =
remains
>> that ptr_eq() is meant to prevent situations where both:
>> The compiler uses the wrong pointer for a load, and
>> The CPU performs the load earlier than you want.
>> If either one of those doesn't hold then the problem won't arise.
>=20
> Correct.
>=20
> Thanks,
>=20
> Mathieu
>=20
>=20
> --=20
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
>=20
>=20

