Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5535E06C
	for <rcu@vger.kernel.org>; Wed, 28 Feb 2024 21:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709155681; cv=none; b=qS5kd8cEqm+DbLYx9BFDZB3RQrSxa5dM7VpC2oC8Hec3rpaQ4Hx9KCMPZEhpcD8hDW+0K3Cw9lbMXONg3i4yd7HmoKh1+vidzhxdSGQPalAVND/2QAYFV/B1WJ4QFp+ZJrVr4W2+ZhWiRJTOumVzyl1NLipJivlIsnFDgQEXtqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709155681; c=relaxed/simple;
	bh=qc3IJmVO/3R3A0SFJHCdwm34OBK/Jh388HY6ha8d4zc=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=FmmG4eadTsrwYWddp9CLY1fO2vbqinHKFPkkV/LzgWxnQ6kDpZwLFCshev0C8KcSnol6gRqLTqHh8vHovoa9S0fu62uipZcDbup5Cax/MEHPVnUfblUDWs6SRqfKf0TlFAwZx+77QZoqRiJ7j+QtxdUL1OT3YxiOyz4kWUprPNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=tmT5AqPt; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="tmT5AqPt"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-42a029c8e76so1253011cf.2
        for <rcu@vger.kernel.org>; Wed, 28 Feb 2024 13:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1709155679; x=1709760479; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Blc6MtZrUfw0pfNXYBqBV8687KOne6DSCmGwF7E1Oc=;
        b=tmT5AqPtLKQA3SMCNqahR+zqrH8scEXZ/cx72tTHM2/ZslivTFN2t4ZB7eGjRg/y+u
         3JsXQnqUAyj/1O0NygE3isVFTcA8dbHOPAjBrRp0M2JjWUg3GDb0vY1mW2iH2oaf/Gkv
         ItY6FkCHH9EPYl1AeuzvBwjYihZzk+NvwOzv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709155679; x=1709760479;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Blc6MtZrUfw0pfNXYBqBV8687KOne6DSCmGwF7E1Oc=;
        b=lWL+d4rGr3gFn/JiMtfhyOSpYIXbMxVG46vg5eZHe7KvFw09cbmrkHj45IYHlngkov
         qaP+CgfXbqk9eV0xMFK7uQQOG9TIcmpx7tqZYPPPgAi9isaeT7FySaHpEPa2XrWvouLt
         VeD8dUz3lxMaWbyBOGx5WlyhI0lgA6R+Ewv40VV9223Y4+vshySNTcYAex/+6Ktu/RDf
         WO/muw/3H5PT2u93pgBJMgOe+Msi8afnC4eXuOCCzWxIIzwC24bCzDvOGVjp4E4Ne3sy
         PmPxIVOB9GtJxTyTgF7YNurMBEpF3HoPTY//jJiNcsWOi5d7pvtOGfcQoPak5pXcnbea
         305A==
X-Forwarded-Encrypted: i=1; AJvYcCW6PmvwyKbGhLMqFybIDStSUVIPKbk5wn2Okv8Cj5jkiBAU6YUVWSn0/x/lLRPmiSeOBuVDo/hQq7kcZ4yHnHMbY5kD
X-Gm-Message-State: AOJu0Yw1xHe0Xg5goBA+6VXGqIBNKKnXJYiFmuAh8GaVd72mlapPfs35
	mU5tnMX8fHLPZO402ma7s1rkEOG186iHWtZnsqTFGkOuOBNyxuOCpwwiLKW7lCI=
X-Google-Smtp-Source: AGHT+IGDQNk6NZQ43wHJ3Dd0O4jJRkuOkedQSDFeACS4W4u7SGJlKnJJwLEhOZq/P68pAYf3qzd8Kw==
X-Received: by 2002:ac8:5ad5:0:b0:42e:7ebf:1d51 with SMTP id d21-20020ac85ad5000000b0042e7ebf1d51mr134002qtd.68.1709155679115;
        Wed, 28 Feb 2024 13:27:59 -0800 (PST)
Received: from smtpclient.apple ([45.88.220.126])
        by smtp.gmail.com with ESMTPSA id p12-20020a05622a048c00b0042e7856fbe3sm12820qtx.59.2024.02.28.13.27.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 13:27:58 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Joel Fernandes <joel@joelfernandes.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] net: raise RCU qs after each threaded NAPI poll
Date: Wed, 28 Feb 2024 16:27:47 -0500
Message-Id: <4965F5CD-B33C-4B75-818A-021372020881@joelfernandes.org>
References: <5b74968d-fe14-48b4-bb16-6cf098a04ca5@paulmck-laptop>
Cc: Yan Zhai <yan@cloudflare.com>, Eric Dumazet <edumazet@google.com>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Coco Li <lixiaoyan@google.com>,
 Wei Wang <weiwan@google.com>, Alexander Duyck <alexanderduyck@fb.com>,
 Hannes Frederic Sowa <hannes@stressinduktion.org>,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org, bpf@vger.kernel.org,
 kernel-team@cloudflare.com, rostedt@goodmis.org, mark.rutland@arm.com
In-Reply-To: <5b74968d-fe14-48b4-bb16-6cf098a04ca5@paulmck-laptop>
To: paulmck@kernel.org
X-Mailer: iPhone Mail (21D61)



> On Feb 28, 2024, at 4:13=E2=80=AFPM, Paul E. McKenney <paulmck@kernel.org>=
 wrote:
>=20
> =EF=BB=BFOn Wed, Feb 28, 2024 at 03:14:34PM -0500, Joel Fernandes wrote:
>>> On Wed, Feb 28, 2024 at 12:18=E2=80=AFPM Paul E. McKenney <paulmck@kerne=
l.org> wrote:
>>>=20
>>> On Wed, Feb 28, 2024 at 10:37:51AM -0600, Yan Zhai wrote:
>>>> On Wed, Feb 28, 2024 at 9:37=E2=80=AFAM Joel Fernandes <joel@joelfernan=
des.org> wrote:
>>>>> Also optionally, I wonder if calling rcu_tasks_qs() directly is better=

>>>>> (for documentation if anything) since the issue is Tasks RCU specific.=
 Also
>>>>> code comment above the rcu_softirq_qs() call about cond_resched() not t=
aking
>>>>> care of Tasks RCU would be great!
>>>>>=20
>>>> Yes it's quite surprising to me that cond_resched does not help here,
>>>=20
>>> In theory, it would be possible to make cond_resched() take care of
>>> Tasks RCU.  In practice, the lazy-preemption work is looking to get rid
>>> of cond_resched().  But if for some reason cond_resched() needs to stay
>>> around, doing that work might make sense.
>>=20
>> In my opinion, cond_resched() doing Tasks-RCU QS does not make sense
>> (to me), because cond_resched() is to inform the scheduler to run
>> something else possibly of higher priority while the current task is
>> still runnable. On the other hand, what's not permitted in a Tasks RCU
>> reader is a voluntary sleep. So IMO even though cond_resched() is a
>> voluntary call, it is still not a sleep but rather a preemption point.
>=20
> =46rom the viewpoint of Task RCU's users, the point is to figure out
> when it is OK to free an already-removed tracing trampoline.  The
> current Task RCU implementation relies on the fact that tracing
> trampolines do not do voluntary context switches.

Yes.

>=20
>> So a Tasks RCU reader should perfectly be able to be scheduled out in
>> the middle of a read-side critical section (in current code) by
>> calling cond_resched(). It is just like involuntary preemption in the
>> middle of a RCU reader, in disguise, Right?
>=20
> You lost me on this one.  This for example is not permitted:
>=20
>    rcu_read_lock();
>    cond_resched();
>    rcu_read_unlock();
>=20
> But in a CONFIG_PREEMPT=3Dy kernel, that RCU reader could be preempted.
>=20
> So cond_resched() looks like a voluntary context switch to me.  Recall
> that vanilla non-preemptible RCU will treat them as quiescent states if
> the grace period extends long enough.
>=20
> What am I missing here?

That we are discussing Tasks-RCU read side section? Sorry I should have been=
 more clear. I thought sleeping was not permitted in Tasks RCU reader, but n=
on-sleep context switches (example involuntarily getting preempted were).

 - Joel



>=20
>                            Thanx, Paul
