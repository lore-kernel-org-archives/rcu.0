Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793732725;
	b=a4LLOH6QDkt3DHur53mUmnFGVvgxVdUib2rdn2NvtKBIgZODBLMTCMePs9f4/aAxjMlj
	 C7o6HdHvHpA6GKckoxs4gkAe1sgv6V89GGfFkKXaEKvPLMfmXqftT2Tp9JsulMPY1CkKT
	 KeaEwv5JRBV1PFR1+B3lYodK7XmQqTJBv7OuI1uWlpbHu9fJ/1aZFh2ZSPqRa08/GiQS4
	 qHSN96k6dDv5Gz0lgkbM6xq5qeptJ/T9w2TAF5HZISzsApu8ag6/mU5cVmo0Md+KRVLP2
	 +GJmoAgM8y/zKanoIqM4QRwps5nUPKV9LGIf33LW544PHL7c9DFmVN2Q0DVne53LThg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793732725;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=WtXsrBXeBrmea4xy+IMxZHACmlbGQ2t5B9G23jCH2E8=;
	b=sWSHr0E4aRUeJhtcd17rQA1wd6DzJ8wOnA7YI9HUAD6kSwrR+Ac5Rito14/e3zndI2J5
	 YwqlMKS4PEqM8Ps6V0a+DN0w/VcyBWvuX3aPp97rY20VvXNtG7W+YvkvvC8l0y3GJRg8K
	 Zw9eYaXg8sPWRCgK5dFT1svBOhta4Ane3+GR5VSNlGwquBpw5InYHSU1eo75AJgDnObNp
	 akr20tgPdS24Y/zus3RaXylkx7pIcRDz8MkGp07KF9IMOuX4FruhJeB+ELbIW2+5HETzY
	 ygEjo5ZKUz2bHIQyt1aHp/4LD9Qir2l5zCbsVKYHIhPGMO+aHcXHouCFdu4uOlWkyug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="IV7/fYpY";
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AC6606A324
	for <rcu@vger.kernel.org>; Tue,  3 Nov 2026 19:05:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35AC6606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IV7/fYpY
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a4d7ae1ae9so45212925e9.1
        for <rcu@vger.kernel.org>; Tue, 03 Nov 2026 11:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793732723; x=1794337523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WtXsrBXeBrmea4xy+IMxZHACmlbGQ2t5B9G23jCH2E8=;
        b=IV7/fYpYNuBEtNqc5z1/sjDc1RqRj4DijHdpMzPFCxf/E24ZACHz77CR7SHexFtAe9
         tzcuWCn6wUJSnOhsvrSJtxIMUouWHiVTKu3D65sP/y2q1pCmS3P56xpnkpHyALf2ZUZT
         2ZZntWnRVaMY+fhIRaTY6np78zVfPAWa8nsY37SUpOyBoWKcLONOkVjsZoaRpUlCDqrO
         D8PbhZ47XE1SZvIxeqHu/C9YPvuc4XBItAGZWc5lt8E03oGf4h1GB0SOg4c2+LZbU80o
         FBRuXHr+VXeHBqv/S6CYx1yAo7eUclm6CKCBgNXqdatTkvJtNLM5RzYyelSZ8k/fTVyR
         ZRQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793732723; x=1794337523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WtXsrBXeBrmea4xy+IMxZHACmlbGQ2t5B9G23jCH2E8=;
        b=P6/VAA9bnw2sGkz69cmKn5SR78m/ZY4fWrAqXRdNqQCT6rtsojYkXx8MlSaHTetJcm
         PYtCrQUnRrH49nojT7c3zaiK/NWOrH4pSu0oEixjn6jI1jRfN281JbgO1IC/q5fdZIRA
         Oj1dfplqIED7M6Wtv2O+EOqK9GYi/kkdWiLKpOTUvUkOej9mTBau6irWy1Vin5RbIuTB
         oKRnJFFI0aJoPfAIsxlrBH7UGhfAMjfqjBdTvAu5liJhX8SU6O8ue/hjqAxLkib+N7AW
         3V+hhm1SVXrtdi61cpOiC51qtl6S5TTq2y+7amHrqkm8lloxcHkuThAGJScrt77C0oea
         yoOg==
X-Forwarded-Encrypted: i=1; AKwUvBxVWY2fMjFEVd9yDREpqKm8kAQIK3gxW1P0Mz4TFAzsDHyz6pB3Umw4KqZ7fu9EGDg63RY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+vmlpL2Z4OoejNK4DyOzifgco0u5VFfPduoWIajBJVfB3rEAzW
	1gvXrMLYxr8iIL9qdS++cU6+/a2QZEN+FF0772sJ3HOGiWv0aApd7ONH
X-Gm-Gg: AYBFou1rEqd8/mdOnFFxVhCIFBKcCw2721xJPzbs+k6IiuY6MMY7I+b3dmmjY345jf4
	qM5RLhBpJhMAgu6ZuWsUV7d/u+wDGiS07t15MkE22dOK5oJNK5NqAsgn0vdF2Y7zLH4ZIM3s+/2
	tzfGAWK2C478hRKDHGSZRyK5+tclWpoky+ey6bVSaq+t/txutUOc9F6fhCNgeIyGHjdMdwFPU19
	ONEtOhexuOcxxWx70LSEBn/Ydhl6hQNDWv7c56/F7cokZOTV04x49NFg5PNMVVRV2pE11ipXKy/
	yvWXsjWnu2dit3NIndlSVOYjGG2mViV9So14AZcbM86IgDQBP1ZdBloYIu3V3xOweyaSIvmwQwP
	PPUE/lOXCuJhfhifgwU20W9dYHFhF5uqU1E4fkkDU65Pr7Pg5kwzzMMBfBIp1ofFqVth3JvEs6A
	o4fLsqqucXofyYcVf870DVLIVkHt0bctma1W7E5sQqkZa781qorhR4karaGHaB+WV5gvmFuDxRy
	yjMv9Av4PWw5NmCu7iMgK4FD6/QNasgxzDdIegxAzYe0/NV9UyJrb6wYiuAWJPUldfXXdVqaWeA
	HwJcLAd32jz9d8NytNTnO2RQ5/gflavoqSDsjg3OfzdtwPPsmJHmv7GanXm154pLtuR0X8VkZ0y
	LkyBw/jjB
X-Received: by 2002:a05:600c:8116:b0:4a2:150f:160f with SMTP id 5b1f17b1804b1-4ac1913eecdmr318548705e9.25.1793732723261;
        Tue, 03 Nov 2026 11:05:23 -0800 (PST)
Received: from andreayoga.wind3.hub ([31.189.68.219])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b4104d600fsm4202845e9.0.2026.11.03.11.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 11:05:22 -0800 (PST)
From: Andrea Parri <parri.andrea@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Gary Guo <gary@garyguo.net>,
	Bradley Morgan <brads@mainlining.org>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	rcu@vger.kernel.org,
	lkmm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -rcu/dev 1/4] hazptrtorture: Release all deferred hazard pointers before stopping
Date: Tue,  3 Nov 2026 20:05:06 +0100
Message-ID: <20261103190507.1913628-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <178eaa0b-e7bd-455e-ac3c-f1115d731a52@paulmck-laptop>
References: <20261027163811.2470569-1-parri.andrea@gmail.com> <20261027163811.2470569-2-parri.andrea@gmail.com> <eb59edbb-c6e8-49c6-a426-c55cdb792853@paulmck-laptop> <9da03ed6-fea2-44df-8aee-f7a61a1d35ce@paulmck-laptop> <178eaa0b-e7bd-455e-ac3c-f1115d731a52@paulmck-laptop>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Nov 02, 2026 at 08:50:51PM -0800, Paul E. McKenney wrote:

[...]

> How about like this?

Works for me, thanks!  With it and patches 2-4 on top, two 3-minute
PREEMPT runs with kthread_do_pending_ms=10000, which hung without a fix,
and a 30-minute PREEMPT run end with "End of test: SUCCESS" and with as
many hazard pointers released as were deferred.  In one of the
kthread_do_pending_ms=10000 runs, the writer also stays in ->sync() long
enough for a writer-stall report 31 seconds after boot, and moves on by
46 seconds.

The variant from my previous reply, with the pass right after the
reader's loop, passed the same tests, but there is no need for it with
this version, so I will not send a v2.

A few small things below.

[...]

>     hazptr_torture_cleanup() stops the kthreads in random order, which

The order is fixed: do_pending, preempt, the writer, then the readers.

>     Therefore, make each reader clean up all deferred hazard pointers,
>     which means that after the last reader finishes, there can no
>     longer be any deferred hazard pointers, which means that the
>     writer can terminate promptly.

With the pass after torture_kthread_stopping(), a reader cleans up only
once hazptr_torture_cleanup() stops it, so this also relies on stopping
the readers before the writer.  Maybe worth a sentence here?

>     hazard poiners.

s/poiners/pointers/

>     from the pending lists as were deferred (reldefer: 983727 relundefer
>     983727).

These numbers come from v1's patch; with this version, the 30-minute
PREEMPT run gives reldefer: 657653 relundefer 657653.

[...]

> +	/*
> +	 * Stop the writer only after do_pending, and do_pending only after
> +	 * the readers: the writer may be waiting on hazard pointers that
> +	 * readers deferred, which do_pending releases once they stopped.
> +	 */

do_pending no longer releases them; the readers do.  Perhaps:

	/*
	 * Stop the writer only after the readers: the writer may be
	 * waiting on hazard pointers that readers deferred, which each
	 * reader releases once it is stopped.
	 */

Also, "hazptrtorture: Nest a second hazard pointer in readers" conflicts
with moving hazptr_torture_do_one_pending() up, as both add a function
after hazptr_torture_defer(); keeping both resolves it.

Thanks,
  Andrea
