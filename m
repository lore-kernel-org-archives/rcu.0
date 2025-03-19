Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC8B20A5DD
	for <rcu@vger.kernel.org>; Wed, 19 Mar 2025 21:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742418321; cv=none; b=qQtmsbwhMAXjMVHj5zaXKTTzMqa5f2mcDvkpp+y5OmkhFgZ1EbiDCqPeDscwqO3w+jmCGChXQPy8/7xGIMw98TihCSfpv/FNgxojithGDxp/c+5vR7OyuEvgTRQPJT7eyjPwwwxgnmk2MwgKZKrN76XP8oFSgvp6tmIVBfoORFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742418321; c=relaxed/simple;
	bh=wZVQ4hsuRwaV3+B5aIu6cZS/QxGDrteM0Xaoq0hBlXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fQlnx8MFkHDKz0nxfgD0FiPogN92tIzcnDF60wf7rFxUf1fxAe0SuYxFXkMYAVFvm3GUTeBIWColF+KSr0vFaL0/vqt/0ityVnReo/ZBHLgzeJsobOlKesOIZjok2PgicVno+3ogl+JaohfGJXPIU9AAOmUaAf3SoZ66jVkEDcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=c4PPSgGj; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="c4PPSgGj"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2239c066347so200705ad.2
        for <rcu@vger.kernel.org>; Wed, 19 Mar 2025 14:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1742418319; x=1743023119; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oqBu+kgYhUgJYB6L1gDuORiFdkjW7KdzRSCRaQJGoA0=;
        b=c4PPSgGjCnxe4wDHg8eHtojNa5jBtwT/7h9FQrwQWZaVzQp3uEWdqMp7wU0FaY9NXz
         /6uj3vb4Wa5Jg79xWMWMElbs7TRsZFhWUtV9MSBDDZ+5Aq8GtZowSj1pr3H5DoLeIbGl
         X4Hq7+1Fd2i2rDd+O11/Y1/UWhMA/c+7E0ZN8cV/Y+naAC3+tQXkObQI/U8qxv6fm/dH
         8Cc7yLHJTy0B3j+aQvGDiO8oywzebvINrDFreKj11bl7JW6QIcZLQ7g53vzXsyl2pwMK
         9KmVA1ljEQNwgceLfeosgfzeqnZMH1R/8ekp3nPwTfxes8TVecD/h0/Vfa7USZoxXWIS
         2Hpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742418319; x=1743023119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oqBu+kgYhUgJYB6L1gDuORiFdkjW7KdzRSCRaQJGoA0=;
        b=cxGhq1BGqrGmrDm3C6PFdivnxSZXSQwCFR5aXnL0MYGTdUd54CSb6zGL8mwS2yovRb
         Wz23YHepE2yR5qECtE3FYlFmwdqYM0NYtUoJ6XnC0lo6t1n7ehpe4N/GRH6WPsHbxV/Y
         iTZjPk2m9o4EXGDBOQDU4oYwOQ7V8hFdXDbxzHxF4EWisCBoewCYtiK9CbsLON/QlDg8
         R23DB91LFYKiCEQdno8g3y43KMQBSqLPi7Uv8u2NdgCG6tG4yOLLGGFzUVg6e/5R7qER
         5+6hzkfiIz3zburyiwLSN8MxFtV1b0LZ7bN5u4jHsgg5/AyNdKo2yPc74s1IU+2dlhq7
         T9lA==
X-Forwarded-Encrypted: i=1; AJvYcCVAUN9qhPvzdG2ydmQ+tt0lo+cgVzsHEiBbDlKTUz/yHSR2nr0VqycFhEsMTe63wYhqGFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV9NgxberD3etTZgwItK2zewrChOChTgc6kct/l4xspoKZnxne
	udJHksB6mQcHK3omsVWcnYEFDiY5T3cTVFTzY2vTKlex8YDnvDMck6516XIB806gL85tPb3TPKP
	rlW5aA4HFdKbghYHmUUtUHk3AzqqDsX+VfVlJ
X-Gm-Gg: ASbGncvs5qj9V0Sdzf63cV9qGnDDBBdeikO0Ke6gNUkhm2ZN+dGeRK3h2jChhn9u+PV
	hQNq11LZuwIpZNwl9mX9XtfbXgAQNbxnO5TQaOJ1vELeQm/T2S4BUwQPtE0Kj+cbKh/FwhVBmav
	ECkbZXUwNGB8CkABZpO0wzmew07w==
X-Google-Smtp-Source: AGHT+IGYu2CZY0ch9LsszI9B1DQF7eU+Zu+ZJjvMbfDVHeKlPF7P5e8HZdt0w4kioSMnnwuBfCBHNKoWSDD6gZiOruM=
X-Received: by 2002:a05:6a00:4608:b0:736:34ca:deee with SMTP id
 d2e1a72fcca58-7376d60f54dmr6415226b3a.7.1742418319237; Wed, 19 Mar 2025
 14:05:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319-meticulous-succinct-mule-ddabc5@leitao>
 <CANn89iLRePLUiBe7LKYTUsnVAOs832Hk9oM8Fb_wnJubhAZnYA@mail.gmail.com>
 <20250319-sloppy-active-bonobo-f49d8e@leitao> <5e0527e8-c92e-4dfb-8dc7-afe909fb2f98@paulmck-laptop>
 <CANn89iKdJfkPrY1rHjzUn5nPbU5Z+VAuW5Le2PraeVuHVQ264g@mail.gmail.com>
 <0e9dbde7-07eb-45f1-a39c-6cf76f9c252f@paulmck-laptop> <20250319-truthful-whispering-moth-d308b4@leitao>
In-Reply-To: <20250319-truthful-whispering-moth-d308b4@leitao>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 19 Mar 2025 17:05:08 -0400
X-Gm-Features: AQ5f1JoRzWT7Z7j0VHgURamunfPE54qbAEp2C2JXfoZJFMWPsaolLFCk6I2GSlQ
Message-ID: <CAM0EoM=NJEeCcDdJ5kp0e8iyRG1LmvfzvBVpb2Mq5zP+QcvmMg@mail.gmail.com>
Subject: Re: tc: network egress frozen during qdisc update with debug kernel
To: Breno Leitao <leitao@debian.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, longman@redhat.com, bvanassche@acm.org, 
	Eric Dumazet <edumazet@google.com>, kuba@kernel.org, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, kuniyu@amazon.com, rcu@vger.kernel.org, 
	kasan-dev@googlegroups.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 2:12=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> On Wed, Mar 19, 2025 at 09:05:07AM -0700, Paul E. McKenney wrote:
>
> > > I think we should redesign lockdep_unregister_key() to work on a sepa=
rately
> > > allocated piece of memory,
> > > then use kfree_rcu() in it.
> > >
> > > Ie not embed a "struct lock_class_key" in the struct Qdisc, but a poi=
nter to
> > >
> > > struct ... {
> > >      struct lock_class_key;
> > >      struct rcu_head  rcu;
> > > }
> >
> > Works for me!
>
> I've tested a different approach, using synchronize_rcu_expedited()
> instead of synchronize_rcu(), given how critical this function is
> called, and the command performance improves dramatically.
>
> This approach has some IPI penalties, but, it might be quicker to review
> and get merged, mitigating the network issue.
>
> Does it sound a bad approach?
>
> Date:   Wed Mar 19 10:23:56 2025 -0700
>
>     lockdep: Speed up lockdep_unregister_key() with expedited RCU synchro=
nization
>
>     lockdep_unregister_key() is called from critical code paths, includin=
g
>     sections where rtnl_lock() is held. When replacing a qdisc in a netwo=
rk
>     device, network egress traffic is disabled while __qdisc_destroy() is
>     called for every queue. This function calls lockdep_unregister_key(),
>     which was blocked waiting for synchronize_rcu() to complete.
>
>     For example, a simple tc command to replace a qdisc could take 13
>     seconds:
>
>       # time /usr/sbin/tc qdisc replace dev eth0 root handle 0x1234: mq
>         real    0m13.195s
>         user    0m0.001s
>         sys     0m2.746s
>

Could you please add the "after your change"  output as well?

cheers,
jamal
