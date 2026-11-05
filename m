Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793841963;
	b=Wbn4e23Np3LWsv5bXmy2UJFwPhoVjtbee25e0cpqLXcFmqVIGBUhyNcPXThdI5CcnpvG
	 WOpS8ERzp8D4KVymEVClqT7ueeRj1z2bWAT67Pldgm9YK5mufoZ+wHRsUxnL3IiSHjTT/
	 ktRxVeeBGY8N7/epodCVv1oZ2L8bftgZCg5kanDvLsOEQb/R39KaNKxzInfZeim13jaiG
	 bxkvs7dSNoxgCm2+6wYtc5n41McBJgk6EreMfveHzbSLo+bBcQPuOAmkEkcfuW4bfj8Z1
	 nkVs+2JAlG4+JxS4NsfTLP+8U5hxjlkSjspBN7lhZjCz8KyKlwgNuiQYUyzm0X6OIhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793841963;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=wJmfnRvLC1EfEtRsVvAyQqePX9S5Xn9AJOFw7AAvahE=;
	b=hcDg1mC/80vtOa8d2eoRK+/2TLeH7bA9xNXuuDblJZemEmMWyG2NukvZidBQaRCh9S/R
	 87++RWDeSjvY9q3k4SeJZmRxRqk5YaGuSeN8gZqRtbj7QV3zKMobCfWw+RcK1smVgVIBg
	 Qv4Q207ULaXISU4rSPjm7u2tpMrAEwKY0x6fnKFUfHId2XosHTHLN3IHMiDmBqj1EFyb+
	 6WZWxzyKgOIa8SgyKv9pmP2S125tytvCRT7yzNKSWVOe/lmx3dSt1QX+V2GCLMENj6qlS
	 sVY2R+4NxPntlAkWx6324Nimw4jnzAnDvzvZMait467LXBQpSsoiDz68OQ5f2HpRUIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=URcG2K+V;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1906F606A329
	for <rcu@vger.kernel.org>; Thu,  5 Nov 2026 01:26:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1906F606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=URcG2K+V
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1a3c08d6928so2047852c88.0
        for <rcu@vger.kernel.org>; Wed, 04 Nov 2026 17:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793841962; x=1794446762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wJmfnRvLC1EfEtRsVvAyQqePX9S5Xn9AJOFw7AAvahE=;
        b=URcG2K+VISfVk77nz9AxluxAo+6zOOU5BLm6U+wbfBxbJBSZ9mhRID6K3Fe0vr1dTt
         bGpBFinlx4Fc5TEHebUr8BZPeWqVY0zBtfX9rqHnjIm9pE4F2ziLMJM1XWxCuSr1C3qb
         f4L1Aa64IMK7FZvtc8jzMRmlnPm2EMmLMEYFxSv0JF8da0G822EL9BzvSYEuzrO1wUXJ
         kRZBhx4aamC84qem21tXx9NXtbhTj8quUvNkKgtFAFtFFE8LxVeolmqjDKwgy65fFeIw
         ObC7n755oIQJ4fh9m0/sbvXXl5S9+XBzr4mvMlUfH/+ELdadHjY9YNbKyFTruYEp++jR
         to4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793841962; x=1794446762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wJmfnRvLC1EfEtRsVvAyQqePX9S5Xn9AJOFw7AAvahE=;
        b=n9QGuphuT6Q0dqwo/QYvRcQhSDLHkP+xW2Un/E37BF+kDZuiymAWIhRyCm18csPtkX
         2Csd9sOMVZb3kaSH6Y0GDb+Cg7DA+OQhz28sUXFY5x5eBCPK7jLOMTwwKL5hyv8EP4Rm
         uRNTNyA4ebYr1sCULALLfH18BotcWAaqkCKWb5eCQkvaJIhlr/3r7h8M5s6FcY4YdD/S
         Uy4uReQPVyBtAYTRFiCki2D2Umjqy97XVBbRfrNfuymnWk1utKlKVf95vsFYcHMWIopN
         tji9/dhb5h3R24XMeXq+NJ2oiQPC96imlkSdS7OG+j5vw+zgXNQ8oVCARL+6UOfuNP42
         T02A==
X-Forwarded-Encrypted: i=1; AKwUvBybBygMlMHaHwgVLwO9mhI/Zh7n4s5MCbDP01heG0KC+SgOInhC4za4FV2nQHU4nTrtdvo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Iq90+/9yuoWT/QioD9E1OicIsT+ZQMi7iJzdPl75pmWTn78+q
	BlOiE7lriZsfuaDze4aQL7Y5QD9T3VPhpLaEBpZ8anKDd284+3PWZJFm
X-Gm-Gg: AYBFou0HD2U2IjUNoF9twjQ5x3oZXAeljxkTVTisjQ3RHzYsfAIppkmQ27dXY2udxVe
	f3+8142B0o/k5enVCms7PH1d88UlkNtE7Voh4kFoSaDowTJeYHEqrP6JUoiqfS3CokVc62cJFiN
	C05o4AyX4LO25BpfZEccj/+8uV4hOfE1a8Rxz12JOaXz80PWqUrJ1U/uoznJHI0O4iPesTechyJ
	AQ7HGO2CcsOdonw1xbjfoBegjgBKWHcTYMF5Xvn35Vr1uugLh24I1V2BszlXOiNATyWL4dm9/F5
	LWu8G2I5tVn/r/ZTmaWpxxOzeihT51aX+G89zKjUVe/mIRo2VleMxggDaeSL/8SlVPOD8jf0kh5
	Pg/PyH78ToZLEABptUVAN3uYxGnJOlkDnVVrqJYULYcc2SNYBa8TzzEgeW0Y+xpc3+DEW7crC0m
	tYfA96qE9J7YA+Om+3w3pBBDQeyGrwN3GspJKJ9scPQijKk6T2X6QZdKTp/v9oLY8fe94Bnzgks
	VsNLblHUEvvEaSfQDtXpLM6OzTvqae1m2c3JbbKvdSbTfrZEBoEPB9qqH9IMxjj0zRFyrQ9hZL6
	Ae0/6Nx7q/8lFZb2sD12
X-Received: by 2002:a05:7023:d0b:b0:144:e535:3ef6 with SMTP id a92af1059eb24-1ac5de53bbdmr27814824c88.41.1793841961963;
        Wed, 04 Nov 2026 17:26:01 -0800 (PST)
Received: from ubuntu.. ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245b8822fsm13868493c88.2.2026.11.04.17.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 17:26:01 -0800 (PST)
From: Qiliang Yuan <odys.yuan@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Josh Triplett <josh@joshtriplett.org>,
	=?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] srcu: Add list_splice_init_srcu()
Date: Wed,  4 Nov 2026 20:25:56 -0500
Message-ID: <20261105012556.634691-1-odys.yuan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <9f8c94ff-29e3-4ea5-b9ec-b04b2bc21b1c@paulmck-laptop>
References: <20261104-bug-nvme-remove-ns-srcu-v2-0-feb64ecb96ca@gmail.com> <20261104-bug-nvme-remove-ns-srcu-v2-1-feb64ecb96ca@gmail.com> <9f8c94ff-29e3-4ea5-b9ec-b04b2bc21b1c@paulmck-laptop>
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

On Wed, Nov 04, 2026 at 09:14:12AM -0800, Paul E. McKenney wrote:
> I am not inalterably opposed to adding a list_splice_init_srcu(),
> especially if quite a few more users show up, but here is what I was
> expecting people to do:
>
> 	static void synchronize_my_srcu(void)
> 	{
> 		synchronize_srcu(&my_srcu);
> 	}
>
> 	...
>
> 	list_splice_init_rcu(l, h, synchronize_my_srcu);
>
> We need at least six uses of the above idiom to break even on the line
> of code required for introducing a list_splice_init_srcu().

Christoph, as Paul would rather not add a helper for a single user, and
the idiom above doesn't fit nvme's per-controller srcu_struct, would you
be fine with taking v1, which open-codes the splice in
nvme_remove_namespaces()?

  https://lore.kernel.org/r/20261103-bug-nvme-remove-ns-srcu-v1-1-e239087d63ac@gmail.com

It fixes a crash and is meant for stable: a reader in nvme_wait_freeze()
can walk onto the on-stack list head and use stack memory as a struct
nvme_ns, which KASAN reports as a stack-out-of-bounds read, followed by
a page fault. A shared helper can follow if more SRCU users of
list_splice_init_rcu() show up.

Thanks,
Qiliang
