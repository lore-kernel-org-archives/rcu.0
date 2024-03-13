Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAB454725
	for <rcu@vger.kernel.org>; Wed, 13 Mar 2024 21:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710366844; cv=none; b=mN50gzEdeVnYcaGZQpjNf+AVOZxeu6c0ky/4z7F4wqJxGOWPwIIVi53JiXnAbBMe8d68RvDYOxdryLgl8kTS/HyNHUKu5uufsyYii3rlMkgQnUJs1ZRaW3hKfvmhr1NODO1MoJv6m7g56LVkOSwygljGkhPwA1TBYADwlc8qR/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710366844; c=relaxed/simple;
	bh=IS+WsJ5TLvLtZdo+Uk62ZZK6uhmnItQcpKASq8gj7aw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bhO5edqy80yis1l4EuakAzejpiOnYCwLq8uvix6UC1Dthy9N3v3vs9eytHUM/Igj7/mKy76Zh/qssyyKhdFXGfmISaT3QwH4JukCUwmAik2VZLaD+5m4S2EoZwHiPNi9/QMH72r92cgPEJJFzw4RI0m8UOaawHj9e6tErOdGNb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cA6e+Bbz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cA6e+Bbz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710366841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E2KPW5KF47bF+5Cf+8HkAv2DAr6yEshp1fbNv4HMysQ=;
	b=cA6e+BbzVgel1bDgxk6HnILWxb/+MrOte7ZAYORLgM6wZeP7brEMJobeQAtIhMPpG12tYm
	A07WMH5Ki1WRELc9WK9kVP6zbwJKKG/91c875UmjXd1dGzBVK04scrN3CCZssYeBX1gbyq
	u8w3PSPJs93EXFTxpSKIx7CR769aLK8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-HX7saj9lM_KQEsQ5kVDicA-1; Wed, 13 Mar 2024 17:53:59 -0400
X-MC-Unique: HX7saj9lM_KQEsQ5kVDicA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-412db0e24aeso1530565e9.1
        for <rcu@vger.kernel.org>; Wed, 13 Mar 2024 14:53:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710366838; x=1710971638;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E2KPW5KF47bF+5Cf+8HkAv2DAr6yEshp1fbNv4HMysQ=;
        b=nKQKK0ldeKopwoqopiL18Tpn4Ta3zh2h5Q151A6ye8CCWgP6bm30mdSvXYWweV9Oom
         gFsExotYEAdjGstYkSPqVN1VAkDGeBEtsGJMq11NGScJZFdfHWFYIn3iy3YXroc9S+5w
         1wQ+k/R1k8XdcYac0kB2RB3xDyHkn/MdJfsLA75Bnz5IQapYA5CZgHui4nT+8gZpDZTA
         j6PkgLvEEwh6DVnpBzDpSeUlf3HD9zf/tScbAK2ZIxE2zjXLGO1tBbJYMn0zI/HZAYhd
         TEtqiqWxK0k15S0FPWPVZmEaHP1ITmQ4N6mhgjH2uuuPSA5eNvxVXNwlXhMDgMR9QHTU
         Iwgw==
X-Forwarded-Encrypted: i=1; AJvYcCVqm6ggtPzTmWC9jY34GGCXWOb/kHa+/xXE/JXJi+Z2kcAfSphffyUXoVGDNIDiu68oSj5qBecavof34sTyTLYY4BBL
X-Gm-Message-State: AOJu0Yzyjye2plOEstIiwO8d9R2QvWC3QUsxCYaZlb3wMbnP7mwGtsjo
	hmm4MGWmQI4m3JbpQo1Q/LPa/lbzEPWOW20dypltkzqgPO78533PTMwnyEfZL9oTNH3QKgox6ll
	Psfzm0g7X1GqMx93xh88hp+LLKY6+a6CRv4hGvi011nqNErNxeg==
X-Received: by 2002:a05:600c:3d96:b0:413:1012:5b6 with SMTP id bi22-20020a05600c3d9600b00413101205b6mr49525wmb.22.1710366838608;
        Wed, 13 Mar 2024 14:53:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJ0OheeUPMmjuVVJzjxLnfhEvsYHX+e2ieqRk+uD2jbxBCs+tKv1zogU1HQmjXy61sfj7CPw==
X-Received: by 2002:a05:600c:3d96:b0:413:1012:5b6 with SMTP id bi22-20020a05600c3d9600b00413101205b6mr49513wmb.22.1710366838213;
        Wed, 13 Mar 2024 14:53:58 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id l24-20020a05600c1d1800b00413e6a1935dsm313510wms.36.2024.03.13.14.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 14:53:57 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 70547112FDA8; Wed, 13 Mar 2024 22:53:57 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Yan Zhai <yan@cloudflare.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, Simon Horman
 <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Lorenzo
 Bianconi <lorenzo@kernel.org>, Coco Li <lixiaoyan@google.com>, Wei Wang
 <weiwan@google.com>, Alexander Duyck <alexanderduyck@fb.com>, Hannes
 Frederic Sowa <hannes@stressinduktion.org>, linux-kernel@vger.kernel.org,
 rcu@vger.kernel.org, bpf@vger.kernel.org, kernel-team@cloudflare.com, Joel
 Fernandes <joel@joelfernandes.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, mark.rutland@arm.com, Jesper
 Dangaard Brouer <hawk@kernel.org>
Subject: Re: [PATCH v3 net 0/3] Report RCU QS for busy network kthreads
In-Reply-To: <cover.1710346410.git.yan@cloudflare.com>
References: <cover.1710346410.git.yan@cloudflare.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 13 Mar 2024 22:53:57 +0100
Message-ID: <87a5n1pzm2.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Yan Zhai <yan@cloudflare.com> writes:

> This changeset fixes a common problem for busy networking kthreads.
> These threads, e.g. NAPI threads, typically will do:
>
> * polling a batch of packets
> * if there are more work, call cond_resched to allow scheduling
> * continue to poll more packets when rx queue is not empty
>
> We observed this being a problem in production, since it can block RCU
> tasks from making progress under heavy load. Investigation indicates
> that just calling cond_resched is insufficient for RCU tasks to reach
> quiescent states. This at least affects NAPI threads, napi_busy_loop, and
> also cpumap kthread for now.
>
> By reporting RCU QSes in these kthreads periodically before
> cond_resched, the blocked RCU waiters can correctly progress. Instead of
> just reporting QS for RCU tasks, these code share the same concern as
> noted in the commit d28139c4e967 ("rcu: Apply RCU-bh QSes to RCU-sched
> and RCU-preempt when safe"). So report a consolidated QS for safety.
>
> It is worth noting that, although this problem is reproducible in
> napi_busy_loop, it only shows up when setting the polling interval to as
> high as 2ms, which is far larger than recommended 50us-100us in the
> documentation. So napi_busy_loop is left untouched.
>
> V2: https://lore.kernel.org/bpf/ZeFPz4D121TgvCje@debian.debian/
> V1: https://lore.kernel.org/lkml/Zd4DXTyCf17lcTfq@debian.debian/#t
>
> changes since v2:
>  * created a helper in rcu header to abstract the behavior
>  * fixed cpumap kthread in addition
>
> changes since v1:
>  * disable preemption first as Paul McKenney suggested
>
> Yan Zhai (3):
>   rcu: add a helper to report consolidated flavor QS
>   net: report RCU QS on threaded NAPI repolling
>   bpf: report RCU QS in cpumap kthread
>
>  include/linux/rcupdate.h | 23 +++++++++++++++++++++++
>  kernel/bpf/cpumap.c      |  2 ++
>  net/core/dev.c           |  3 +++
>  3 files changed, 28 insertions(+)

For the series:

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

