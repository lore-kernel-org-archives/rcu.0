Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE99C3101A7
	for <rcu@vger.kernel.org>; Fri,  8 May 2026 17:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778259976; cv=none; b=LNdrkcWJWSAcSxgH24G0nl5+essi0TxHGjZIpbTsW2hiiYfvMqrWhMx7/qTaas16/rEJy7so4nC97CxfTsRL4/sI04lXfcFJoi2rtIGna+P+WHpZIPUoceOtWBMIoJP1+8+Hzq4lyrpzLjkAgeQZHga0PQIcfcJn09B2CtlaOx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778259976; c=relaxed/simple;
	bh=Q+ktTo4FbUJFAzWRrnxkkY+XVxKYylNNEPJ6oTFKYoY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CkHyP+6LLua8M9e2l9rYxqOdblDb4loLGy7WL2xgK0xZziMusfm1XB7iDhp0S1rHt9ANIRLWFzpkDxi0F4jT65pY6MGBNN0sPEj4+xIIwL0sSEuNu04QPHCSfUsIRLeFy88wabEh5vg29kr/xWPcpAad76fPzUAiNCALX7lGMI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+Dmo5QO; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+Dmo5QO"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-39396f873adso25681671fa.3
        for <rcu@vger.kernel.org>; Fri, 08 May 2026 10:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778259973; x=1778864773; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vT1Zf+Sny75tjW/jrB/CTfN3SNBcHhHecpeLWbvSiQw=;
        b=c+Dmo5QOWMP84WvkhQX3bbKaB4R4N3wUbzLci7Qf42YNoHmdNnB34fRuYVBjFuBLxC
         PI8IdB23kxCdNIs45s9/NneGwk3MQLOtXoueP7kpuTBk+qTirD34qHlktJDPF9WZJJgD
         Zzl0IyAQsbBNfeEvqROBzvxZyaTVJ9iDQSJ8zcUvR+jHHLgBdl8EQIA2DDxQEQAh4uca
         Zf3AsSMXiDI23XHE+bz7Ps9L0O0o4Oklgl2O4uMKqrsmwZvbE+DlRhx3VakkfSTkFVQp
         VcgwE+AJ5tuPkph9qhI7Uh5ASGgm56E025fgo7MkDQ5butwSRZm4OyJv4xBD2tsofbxw
         ZhjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778259973; x=1778864773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vT1Zf+Sny75tjW/jrB/CTfN3SNBcHhHecpeLWbvSiQw=;
        b=QgFkfmM8g9nBPbpuokOMAkwPHIFiFBoEn1ZY6yEtkDcn5kxOwcibPsL31XQ7S+8QeN
         ulhfSJGlv1kae7isvzwFPLBoTVnoNighVHSS/h+C7WuRYnsw78YPXEdt/61gb5zppUrG
         9d40rZUzEFEbZVIUraQ+tFPsLu0rEQmBp8AvgG2+WBtwl6Bp4vNnbas/DMmBDKbBLyF+
         s/65trnozdVSkDVSwszuTMcEEQwu7mFKccUM9XqaOUGvNv02/++e5z7MrDxILp1wHLAP
         IN5wnbYE9vmVZ2QINLiUflAcCohHMCtsf/5RQAD2Q0H04mPlNQ94oxn32WKlvnvr/egK
         nlSw==
X-Gm-Message-State: AOJu0YxiHpVWZRAh2byL11DIt+L4j7IBkSbwKsgTVDPlqkKWEFwLWMmk
	Vi2EkrJr7uYHRyNm3pM6Giv6JLfD3C5tmeOftAE+UFkLivxf2Xz8LpuQ
X-Gm-Gg: Acq92OHOfIu+uQACX+vSitpBo1Fp4YIaEwOT0K8ryivSadVqQT/qllqYvvZGyCNpa1o
	N+F0/JrPQ1JGH1ZGEsp1hkmVvXVFrgjrrqGUIiWjzPhAb463jxXBOp3gVje0qifTH4cjF/2M4eu
	zDFMIsG/Lu2wBuNyq5EaRTiHOiZPC4qMVyPQYUhuO4WuyaI1wPGnxJgjbdnm9HSKaDUvr9A7q9+
	UHRKGgYkijTx2J+1wSgcxtco4zAAnSAy7G00mM1mucxKO7V/0o7MYm0mNivRGZlCG6OaU2AbOPG
	qcJNejyGli4Dvl/ohSKiql/KfF6dQbKs5PWMHPgE0kolJjfZ8D1FbeHaTWQFHeofMCpJaTN6Ot9
	4vwehsIcZkThRLcYzMhNmVMz5fJUy52JK0pS1Z1NhpRrczrvFU7g5ZN80jBpyvvdw
X-Received: by 2002:a05:6512:3e04:b0:5a4:d44:99f0 with SMTP id 2adb3069b0e04-5a887ada973mr4903275e87.6.1778259972748;
        Fri, 08 May 2026 10:06:12 -0700 (PDT)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-393f6268ddesm6281591fa.37.2026.05.08.10.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 10:06:12 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Fri, 8 May 2026 19:06:10 +0200
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH 0/4] Torture-test updates for v7.2
Message-ID: <af4YAggY4_aj_Qxr@milan>
References: <1e506157-35a8-4ea9-8bb6-cfe899d81e6e@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e506157-35a8-4ea9-8bb6-cfe899d81e6e@paulmck-laptop>

On Thu, May 07, 2026 at 09:57:11AM -0700, Paul E. McKenney wrote:
> Hello!
> 
> This series contains torture-test updates for v7.2:
> 
> 1.	Fully test lazy RCU.
> 
> 2.	Add torture_sched_set_normal() for user-specified nice values.
> 
> 3.	Improve kvm-series.sh header comment.
> 
> 4.	Allow "norm" abbreviation for "normal".
> 
> 						Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
>  b/include/linux/torture.h                              |    1 
>  b/kernel/rcu/rcu.h                                     |    7 
>  b/kernel/rcu/rcutorture.c                              |   21 +-
>  b/kernel/rcu/tree_plugin.h                             |   32 +++
>  b/kernel/torture.c                                     |   16 +
>  b/tools/testing/selftests/rcutorture/bin/kvm-series.sh |   11 -
>  b/tools/testing/selftests/rcutorture/bin/torture.sh    |    2 
>  kernel/rcu/rcutorture.c                                |  160 +++++++++--------
>  8 files changed, 168 insertions(+), 82 deletions(-)
> 
This i took.

--
Uladzislau Rezki
