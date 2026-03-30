Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F653C73F7
	for <rcu@vger.kernel.org>; Mon, 30 Mar 2026 11:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774870914; cv=none; b=HRIzsH7zck60j9VEt7/Wa2PFAgkCFvM0T2ikO06zlUUUfrmOYc8y96+2eFvY9gPQqQO5YIXEwAw6aue23J4cSjFA1aBC3sb57YJsG1fja1/kfZd0NVbIGbZUufTeea++5Gd01Ndy2p+CAiaB8ql7hWiKjy1H3KNGI1AkGP0r/f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774870914; c=relaxed/simple;
	bh=jy4JXObkxn6zs5G9yFF18bF4JPw9+ojVLYoPuhxyOMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HfGKTAdqqBcM0RxnIKrNlrAfhy4KUNk3PMZuwafxTgDXPdt7ywSSrT/z1a2EVHGa94yq9jDgBiH5zSI6OeFsgWiTRQ4uZAllSlrJDkT5mO37KA1LM7DLB1SPLgot39dByu5s25OXIq9cgJKqVWw1kbVsNphhDIp4ywkEVQhS2jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QriGvYrj; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QriGvYrj"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-12a747e7b2fso2016510c88.0
        for <rcu@vger.kernel.org>; Mon, 30 Mar 2026 04:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774870913; x=1775475713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O8qbAM+0abt2Xsw25EiZl6rgD9G86cRKj274QNi4sMI=;
        b=QriGvYrjwcEeiOdDxdSPz/bkSiWT6RprRk+aTdrU2IXcqAPLIIhrTbv20Y+e0dhseY
         Q6r8j/TvYKLQIj64d40XvKCLikE65OUcr9lsDIbDBfzevvQmrfICTTrl1AkZ0mT3MwBy
         kk+8EQSmsb3TvDt3+bRl5Z3n+oLHVlWlkceSFdx8sDA8tbA97aPNzOE85nMfrkfdTOga
         wEGna2Z2tclWxx/xa3UKtYNaAOV0gEWT8seRD8DkFFIwERMaDsSr6X/YmTiL4xvZSWQs
         skweBd8wYRqUIIju2jZDYepRhI90NFLR+VFsZn4fEMP9zXAweOksr0VKRhoJN49x28b6
         0DFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774870913; x=1775475713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O8qbAM+0abt2Xsw25EiZl6rgD9G86cRKj274QNi4sMI=;
        b=RoQqZ0VZ30UOkN5dSgKNd8yN+O2KTTYNn+SdtYseUmkruVEa855jYA/lrO5SxyUEIv
         jTYiiJ1LaiIhtC/Dy2C+51EuCyUZTiigxgz9uz0c743Uw7eLGVKzOzvOgeNt9gwP2PN6
         qevIQbqJJNJ8z6TIfgLhkcmcb7MqQT4jv1xFoVNFIbtxgl507tbnruBUbRkMf1Sh22kV
         +LnJrDRHz1eh1CDzaTX4z0AUE4I/tdWnbGIkKfA4cFrsgeKtuNKxNl3r2dR1IMk3swxR
         49yGBxUPX+hHUbqMnSDViqSuXBVC7Q7YgMrPlAqT6eEetd7wVl38no0ZBh5jq5+Sf26B
         2GEg==
X-Forwarded-Encrypted: i=1; AJvYcCXWkqybRbqx8bl00vcAozMGG0tNiiFmwJcxwUigOmzvuAiB0Q7A84t9RLxfhg9+epyM4/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGPQqO1051AY+XQhwuc+GI7Ver1Lp9f3OrNyOe8BaKMSNocA6H
	kKk2HcR264FhuISexnXb0UTbIFcuPxr9EJ7agvBaRFLe0CyuAZXwOZ8A
X-Gm-Gg: ATEYQzz/5yb8kwD0pElfiSCdPDqvQYAS/7UIV+K6h7NDDjpccjd4KI6uGOWCz+jnGV2
	9QSgyPJuyq+xAQYNY51b9tVosTlpeU0xu5Wcb9fYUi6dISKrASZ4CkuFpXpihBc7r0OFcezZ/71
	LFRYI3aLOPn248ZEPNZ7EiteaqQEvS2DhdATHuO+dKyHgp4LoRrfk8p0eHGxtWffDGreOR19sWU
	0Dwt3rzx5WiuyY2aTsbDe7HlbfwZaQ40Tzl2ayjLrn1Q5DgMhLXQpUW5/ks5M1Pv4nx20b/KkTI
	ZCvefuSvaKw+2WX86Cc0GKoXWvhF+CtN7E13IrxcwxScY8srg15PNML58HsXwOP42GJUbVyHBaJ
	gFWHRC4D7rCpvABxIVadsh+rwFnLwNKqeAiNHS2SHnhjwyV1pIyQti09np6rzGlfDkgjbAu3BiN
	hvQXEkbYQI/0orrNqqyJiCFiQoq0Bn+41zA0Y=
X-Received: by 2002:a05:7022:4393:b0:128:d396:f2e2 with SMTP id a92af1059eb24-12ab2857b2emr5938952c88.8.1774870912754;
        Mon, 30 Mar 2026 04:41:52 -0700 (PDT)
Received: from localhost.localdomain ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ab97cad88sm7602987c88.1.2026.03.30.04.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 04:41:51 -0700 (PDT)
From: Qiliang Yuan <realwujing@gmail.com>
To: tj@kernel.org
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
	peterz@infradead.org,
	qiang.zhang@linux.dev,
	rcu@vger.kernel.org,
	realwujing@gmail.com,
	rostedt@goodmis.org,
	shuah@kernel.org,
	surenb@google.com,
	tglx@kernel.org,
	urezki@gmail.com,
	vbabka@suse.cz,
	vincent.guittot@linaro.org,
	vschneid@redhat.com,
	ziy@nvidia.com
Subject: Re: [PATCH 00/15] Implementation of Dynamic Housekeeping & Enhanced Isolation (DHEI)
Date: Mon, 30 Mar 2026 19:41:21 +0800
Message-ID: <20260330114121.101232-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <acQHKwGhYrpoOH1P@slm.duckdns.org>
References: <acQHKwGhYrpoOH1P@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Tejun,

On Wed, Mar 25, 2026 at 04:02:44PM +0100, Tejun Heo wrote:
> This needs to be coordinated with the existing cpuset and isolation
> infrastructures.

Thank you for pointing this out. I agree that coordination is key to avoid 
fragmentation of the isolation logic in the kernel.

In V13, I will focus on integrating this "Dynamic Housekeeping" logic 
directly with the cpuset subsystem. The idea is to allow the root cpuset 
to act as the orchestrator for both task isolation (which it already handles) 
and kernel overhead isolation (which DHEI enables).

> Also, Waiman Long should definitely be in the CC list for this.

Acknowledge. I will make sure to CC Waiman and the cgroups mailing list 
in the next iteration.
