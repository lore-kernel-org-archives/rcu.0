Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601183BC683
	for <rcu@vger.kernel.org>; Mon, 30 Mar 2026 11:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774871181; cv=none; b=OAUDmu+I421VIexkgU9UgXCh2hRScu85KIu2ZKo6sPRy73Gr+VC+PVEu5g4IGEROJkkH0HpskKCvvRZiKVveXJ3sJ5eHrUAqtRM/6rv6dBohvaHjZcC5kBQ52FMiiTOuW5prKuw5Mr3CgPg0CXN2J7hD8g2/OI1jd/VTQCk6E00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774871181; c=relaxed/simple;
	bh=qTmtyABsMZxVL7dEpA9F+DSHfsWRV7AZpPMrHUVPxZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JYggFLUiZbN2ZGJdPmZlwDaNAUvOV1D6ea1cd4Gh4PPvrYLRSqAV9LyzHKw77gnhb2w/KSl2QVoCgpg7KX1E6MeBpmjVGn15LurkzlQNBZeA1BrrD5CDim6KIF8Hr6aUgsvIHvPkkoE0Ownqi6Hkrj05IRbEzTHKiT14fuoeM+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oQjTBw80; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oQjTBw80"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2c66eafc1easo1250322eec.1
        for <rcu@vger.kernel.org>; Mon, 30 Mar 2026 04:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774871180; x=1775475980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=88r4nrovufv2sJYIOMDGEaf/zyrN4LEqGmAEdjsIQK0=;
        b=oQjTBw80G6CPbV3xb9k8mHMMY66IwAMSWDkSUVihulzz4295Y2owI2WWIbWYbEYf7J
         8l5zspwZvwaZdE2B33Q9sljA5SQvXuRWRLvf7ZNEJuDVyGDszJ8V0nZDlTWWIliaxD7w
         I3STYj8BCUXAW+GgN0aKo/crTBlkkH0MpufaDThuc8MV0/qwvjuOaxSHizaZYmLpvn4o
         0mIfsL/6SkCYJtHrin0XJogiSfOT5oBLGJieUnU7hVhc8wYWf045jWgjvjS8/OijfcBT
         pxF3U92ZF9BtGwpfvlZlPaVT8tch9ocb+2ECdesrqPUclcn7wMB3f3hmPA/PkxnLGETK
         CeHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774871180; x=1775475980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=88r4nrovufv2sJYIOMDGEaf/zyrN4LEqGmAEdjsIQK0=;
        b=CdJNe80rfEZ3xOQbBPxDOdBhtc5Ce0ARLnRX9N8fZzJd9jz56ej0ARveF8jeXbO8Dx
         2lpY+2ucOzsWovgJlniYGkyx+S/Zq5jYG7xoT+JGOFyVeiG/UBaVNJaXLVZXFKRI9UKm
         bxqGoY+KGjs45QsKpYSg2La9nlNHecmDXLtjyNAw0E4FIje+5V3IoHwRuJsGL7Ih2dWl
         JLnEKUOuyI1FZRTlvh8o2QpxMl+EmZYoNBs6hsF0/KhdBAULpeu2EB15iep1HaNFwjvq
         DjH8ooHEg/Xo5F1yKXqGZmRdqhMp1MbnKE8xNfnZKzheTRGpuxPT7oqXJR4UWm0KCVsf
         2+gQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiXCXOhnBugH31oRHM+npw71E7wKkbO2UUtBojeQ/edb3uBdPfUnR/ctphnta3M/UMs50=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqydNV/bQfVC0muaOhciHeYWAICQWpzyh1usnQF7451FPC5BD/
	oOtBaheGATDrRXhnhwcOPFP59q6D/QNwcD9n9X3DN6PxRrDwAQZmiFYX
X-Gm-Gg: ATEYQzxND3zWJYNhmMrTjU5OKS0qkaS5pol48uduKileuEJrPgm1w/4WYdZLUNH2F6S
	E2U8uFQXM4Oy3LGt6nUX7f+RY57S9Gym4+DRIHVC+I+51TnICXCDwospWraWFIaZYHtsBkCqHuM
	Szz2Zi8f/dcwHUu5/ddQ4+SfS7+MnMZAuvE1+DzTpHfYpwCAvlURbipQtxxNOtiEu7gGaUSNS9p
	T6Tk33rwo0eS6OBWKjmwjGaB6CxgW4CHkGJi3NLe/+TZwcvCgj09y3wT99YYtZJv6x8ZXIdmi2Z
	1+Rkmq0q52zCT9FYjrFYPA046zJtJRjkYPWPqcNHNdAkOJnDY9v4Z5XyvbeIvOaZ8W5OCOlmq2x
	uFjT7oD/KyVgFHQpjnT12IFPaycBkhqgEh2LU9xpk20yWvAKuTkqVyYzuFt8+SFCbPu0ruDTRnY
	w0Qh3gzX4mEIClqU1Orxq2aN/+70F8zsSeKRM=
X-Received: by 2002:a05:7301:3d06:b0:2c6:cdb3:bd5e with SMTP id 5a478bee46e88-2c6cdc30b84mr964511eec.28.1774871179502;
        Mon, 30 Mar 2026 04:46:19 -0700 (PDT)
Received: from localhost.localdomain ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c6e9c088sm6703832eec.21.2026.03.30.04.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 04:46:19 -0700 (PDT)
From: Qiliang Yuan <realwujing@gmail.com>
To: peterz@infradead.org
Cc: longman@redhat.com,
	cgroups@vger.kernel.org,
	akpm@linux-foundation.org,
	anna-maria@linutronix.de,
	boqun.feng@gmail.com,
	bsegall@google.com,
	dietmar.eggemann@arm.com,
	frederic@kernel.org,
	hannes@cmpxchg.org,
	jackmanb@google.com,
	jiangshanlai@gmail.com,
	joelagnelf@nvidia.com,
	josh@joshtriplett.org,
	juri.lelli@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	mathieu.desnoyers@efficios.com,
	mgorman@suse.de,
	mhocko@suse.com,
	mingo@kernel.org,
	mingo@redhat.com,
	neeraj.upadhyay@kernel.org,
	paulmck@kernel.org,
	qiang.zhang@linux.dev,
	rcu@vger.kernel.org,
	realwujing@gmail.com,
	rostedt@goodmis.org,
	shuah@kernel.org,
	surenb@google.com,
	tglx@kernel.org,
	tj@kernel.org,
	urezki@gmail.com,
	vbabka@suse.cz,
	vincent.guittot@linaro.org,
	vschneid@redhat.com,
	ziy@nvidia.com
Subject: Re: [PATCH 07/15] watchdog: Allow runtime toggle of lockup detector affinity
Date: Mon, 30 Mar 2026 19:45:46 +0800
Message-ID: <20260330114546.103726-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325140324.GD3738786@noisy.programming.kicks-ass.net>
References: <20260325140324.GD3738786@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Mar 25, 2026 at 03:03:24PM +0100, Peter Zijlstra wrote:
> Why would we want to toggle the watchdog? It's linked to the 
> TIMER housekeeping type anyway, right?

Yes, it is. The original patch had an independent toggle that felt 
redundant to you, and I agree. The watchdog affinity follows the 
timer housekeeping state.

I'll simplify this by removing the custom toggle and making it a 
guaranteed side-effect of the global housekeeping state update. 
This keeps the configuration simple while still achieving the goal 
of keeping the isolated cores completely clean during dynamic changes.
