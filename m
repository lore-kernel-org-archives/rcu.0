Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795492853;
	b=EZRoOgEJgxDpoETNZZRn2v/A8jAxAgQ2RHnpXKfoootNOgNZVRblejtOkirUvh9aCVAJ
	 FN9IfWodsTGpN7RcnZngtF4smPf50D0Ltq372XhR3cSoLkhS7575fpy3q2RYMem5K3MOa
	 uYZohqiU/URLkH9ozyu60Q1KBgnSEJgAfdBr6o6fArT59uspazatJKW0qNeSJ77xTs3p8
	 k7XHGNVbwhl5TjIzMD36zA6LdsMcl+omVnkYb6EjqDffPBz/gmGQXpydBdvKQmN3au3sF
	 LD0agQwiO74WBJQCS6snc1cUlE8mE3Zd6VMkl2UpB7f3S8xTTYTrRDlPD9OsfbIqFRQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795492853;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=35yxV76fuMTZupLunX4MeNiX3puXHVhhoMmA7IX+fzU=;
	b=nx5Ms/5Mqo3XUhCLosdn3pGSUBh74qu4ydKzqMJdh6WXc7m/v+nimemwVzvpT/mOjYdr
	 /np4xOZppxU4DUMj+xqSrbdbemrorIW5nsnYwiKIV/oAv7lvYRvEOIFqViTGSGcOamJ+Y
	 /oSPh4FzKwh3K/XpEu/SXBpKpQkI8l0nBc5kYlfxgQeWq6I/rL018vPIS1ANLHhdcWBvB
	 C+DqOPX65D2A+HhJZ6xwthXfE3blluXbD3AVJeA1aRqEZgDfBUJBi4fZSiD4Ht70wojND
	 pgeg3i33a+8jnUAKDoNLQebE00kCnwFb6fWJ0HddwHOY0ip5M7LKGXYaSiFAMl46zmA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pJydpIHZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.48
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5995F606A330
	for <rcu@vger.kernel.org>; Tue, 24 Nov 2026 04:00:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5995F606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pJydpIHZ
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-679a2b5fe87so3888906d50.3
        for <rcu@vger.kernel.org>; Mon, 23 Nov 2026 20:00:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795492852; cv=none;
        d=google.com; s=arc-20260327;
        b=aRSeC1zgYlPkVaiajsC9oWAYxKV3jqZzsiVjhV4PXeIRFqtw+IDJ5qU0lYAaPk2BlM
         kGFyNRJCc1/OJJgAn6kEVZ8pz+X0NnlIeZQnNBXdsxbDxFkiH7sS3ALx/EHGldgj5RZI
         GbLGNBzalfY38MNUsPYuebNyzoDZbRJLHp3FoOT8uaszRIiWwfqpDxNCHKESH+ZMbYPs
         Lnn8KzXgLgV7zRdCLiYo3Md9VTs3LJcFhfhYWcDmUd2mRiryHqI8R1B/Z/0aUgtuKJgj
         kQIPq9EJAsTFCc6dKcpkXcVHmPw6Mh1SD7Hr1MQTqua9uLY3Dbjs/XjjiuHZgTzd7EKy
         4LWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=35yxV76fuMTZupLunX4MeNiX3puXHVhhoMmA7IX+fzU=;
        fh=WUDOjoo4HCIHdJV/+9P253h4JedTzFf2QykNwNYUJ/c=;
        b=bHkDNv4BARHrYuuVuwpbCJn3LxOBr4K84gJl/jfA34HKQEeiM+QE+mJOLBuInSPafU
         3dv1drPeTKukqJ6+gIDEhNcQNAnHxTsg3jQkD0SR5a2u4pIH8K4Pb6SZf1Yb95yrmdwv
         6MtzsYsg+XSmy+KlMDQcZIJRCW9R1Li/UJA5uPINsPJPMgkI0rohhu3/6S+hhu5f7laU
         20ripSHnl2tGY8kP4l/ReQWlNXN5eV03emjPx631rESBAKZ5fiYLzLORjv7ik+eAhypu
         Kgr3dN6EjRGFjcVJIoVR6A9HjLzsRFeiuyRSgREEdYByBcWrNuAZGzuuBZkNnt88Bauq
         ixIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795492852; x=1796097652; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=35yxV76fuMTZupLunX4MeNiX3puXHVhhoMmA7IX+fzU=;
        b=pJydpIHZC+jgHMbGbpKTWCLHhOdsM07+l+r6Iur+1AhfH/oT988kwuWHphDXcip7/P
         cbRY9NEZIDjPm9AyosZX+sPvzjMrSZfr3OB+obOF2BcguyJL/e85jRu80yQge87IhNEV
         Pw5EtxwHAzUjKkh/1GENQ/1oXtMjOQo0ePqUidxQzhHZpuBboxaYE8e5Eof4XStZLPV+
         n4mJUPW412DeDIJ1zU0Hoct2/PlcexBGHDsxWGY01pkoS2/2OhMKIlICdZWKVWSh374T
         MRegLkHQLpWoA90n2Guv5NgKnEq40qd7n3BG22dlg0/MPsg5LP8t4ZYEG1zJdPvSu9jm
         Idtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795492852; x=1796097652;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=35yxV76fuMTZupLunX4MeNiX3puXHVhhoMmA7IX+fzU=;
        b=hz+XOOlJWcRrOwZyyrldUjT+9vXmGmY0yQmImluxwT/skFQmMIsGy2GV1CGsrtg5p/
         2RBYFqSUtfLs8AKq4tkV7vXWUaqJURHi8DHXbJrrgR9sqoqN8UtYHkiSOYikrXFlvcjk
         XZuC5T21DxcZteXb0Y/a9Hp/aG43wNt7sXg4nrBtz3l8h191FxScTw5r+/DHvm4BXSSR
         y3QRTvSLkAreYzGCq+WubwCAM1hqwT8cXZjFnFbkSvnTB1JQ+okh0fcaZCdHPL4uaz6n
         ESjWtavE8YctCifgJrIbE+aJWMvO82XYY0Xzv8Z0fiE8+wfuEAeHLos+Y6jiVQbS4Qdv
         z9sQ==
X-Forwarded-Encrypted: i=1; AL+hErH0BGUd1SmGa5Sr7dF4oxNfPH9X8yD9aERRV6KF9Ta0w3OyECdoB64YFHwF4bU75LhN8J8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Wu2iYhwq8DieqJkeJvI284BIIC1oeXufYPvfKDn08L8BNqWmZ
	JPD0Yv2AQ5aLitvE8WzigSRRodkjUw3stpWLI8giKD211kl+1Mx4oRdQZ2zpLzJnmqxPYcbZeTL
	94eXP3SlVS2L12suue49hUqtfPDPo0J0=
X-Gm-Gg: AZFdTZeIJQsay/F75cOOnnPr4GQDfRGgiLQAkpMY28eS9XAYltI04am6wqf1W/4CY2E
	moh3BbSQnlSyPUXp7VWWwp3WWYjf0LUZFf9RaIRmptgRWu0chIZlxZXyQaaIo542j9lm7Uzy8io
	rvUqx3e3SByRVbmZutu4Hnc+KLbcWVc/4AZd12r8o9zbhBM6tn733CMx07ueW0zHiBjDAgkRuTC
	NxkKaxpkOQH1P7Mfj5JArAQ16LKtzokFdXrJpmcZ7V5Y0jCMkDLYv9xS4vpqqtCxT3iKNMhZvey
	Z1i2WKxwGeIcc48QeF0O7Ud6HOe14VOGWXRJwMmVp6l4G2hfdUddNFQQnV0fdmnnYfZ/TkfKo/x
	w2UWl6TKe4VM4VmEghmeOQmJ2GLC8/9kk0wP+hVHouIi5fWZ458vSndc19Xv5RSzU05Y=
X-Received: by 2002:a05:690e:4813:b0:67c:1907:922c with SMTP id
 956f58d0204a3-67df44257d7mr2356677d50.44.1795492852350; Mon, 23 Nov 2026
 20:00:52 -0800 (PST)
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123-klp-series-v3-v1-0-427c95811d9b@vt.edu> <DM6PR05MB41373C039888AD13938D3838D1452@DM6PR05MB4137.namprd05.prod.outlook.com>
In-Reply-To: <DM6PR05MB41373C039888AD13938D3838D1452@DM6PR05MB4137.namprd05.prod.outlook.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 24 Nov 2026 12:00:13 +0800
X-Gm-Features: Aa3M54q7s3VMxk7FJweeUn3luJjDb4P7LcCfNfajJc0izoqcRUVhUDIdY_OqAjc
Message-ID: <CALOAHbDu5NmVowk4SHzeUDxASaxKkbL_w1dModFWzdi8yK9tBw@mail.gmail.com>
Subject: Re: [PATCH 0/2] livepatch: Do not lose exiting tasks during a transition
To: "Ravindran, Binoy" <binoy@vt.edu>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang@linux.dev>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
	Joe Lawrence <joe.lawrence@redhat.com>, Song Liu <song@kernel.org>, 
	Ingo Molnar <mingo@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"live-patching@vger.kernel.org" <live-patching@vger.kernel.org>, "Shastri, Jaidev" <jaidevshastri@vt.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 6:40=E2=80=AFAM Ravindran, Binoy <binoy@vt.edu> wro=
te:
>

Hello Ravindran,

Thanks for driving this fix.

>
> The two issues Sashiko reported on patch 2 are valid:
>
> 1. An exiting task that has not been unhashed is on both the task list
>    and an exit list, so klp_start_transition() can visit it twice and
>    set TIF_PATCH_PENDING again after it has switched.
>
> 2. Between exit_tasks_rcu_finish() and its final switch, an exiting
>    task is on neither list and can still enter patched code with a
>    stale patch_state.

We also discussed this issue at the thread:

   https://lore.kernel.org/live-patching/CALOAHbA9WHPjeZKUcUkwULagQjTMfqAdA=
g+akqPzbZ7Byc=3Dqrw@mail.gmail.com/

and Josh suggested something along the lines of what you are proposing,

  https://lore.kernel.org/live-patching/20250124010848.pdcxokfsk2ngrowl@jpo=
imboe/

I did not take it for the same reason Sashiko raised in issue 2: the
RCU exit list narrows the race window but does not close it.
I could not see how klp_synchronize_transition(), as you describe
below, completely resolves it. Could you please explain that in
detail?

>
> v2 will walk the exit lists under tasklist_lock and skip tasks that are
> still hashed, so each task is visited exactly once. It will also call
> klp_synchronize_transition() before func->transition is set and before
> completion, to wait out tasks in that last stretch. It will document
> rtp_exit_cursor as well.
>
> I'll post v2 after testing it on mainline. Please hold off on
> reviewing v1.


--=20
Regards
Yafang
