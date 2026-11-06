Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793967540;
	b=h+mgJgAuzhb9cMNuXNS6unwv8w2B2NTS3xyfgzf1tlGJJSmbdOllxb8kA9gsqMP5VPPz
	 Q56KtRqH8Z9G/zmestoXktG5BKkk/vnwg2Xw8XRYdbcLMG6lj1LIAWbpvx2JIp3xIhQ6q
	 D6QTST8xyGGxTRmvBPnn7jpLU6WOqGA/n3n6dbLowNaBZLFF+6iqH57i6f86sES46ieLA
	 mWCyYNupVkc5R+ujyU1NR23hcOm6bT9fkLfcrOwkoUToAbyUrT1enBRoRPlDOaazLYhWO
	 ROR3NITzenuyjSClItKTJOL8LmpITHuhXGDDdVYpLM89K/O48MXLT0DiL42wKgwgd3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793967540;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Z0rdYCKEnZd8FGC567jnfce1H0VjvyM0Z9c9ULvtLp8=;
	b=JE5+pm10Q8kmgrEvoK2688g2S5ZB7Wa0efh4aGAgOa6cbfpoM8iA73QcScDTbTMmdqyk
	 Qvo1AVirNcDfNrfxJbsWnft3W5farUEchLlq8i3bdtnxCERF00NocDCCx5Jl9f7kPpASV
	 zr7xpE5ifA1DT/87v1hQPorKIMTSY28g8LRlsUjmUZYWgZ+4AKR2dW6w+dOfEXNfeWfsy
	 GQSaMgE8qH3qVr6XZfOSZ2cYxTyZVVtlyXGrton/PKsnvtjdeKKTVoH/MX8LQqq3KwmrF
	 TKTzIFq+RzK0murP6EM1Wkz8E+csQTYLBb1E2+upIKsaFz+KPliTioA05AYHFwr0mpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S1eGr1gU;
	arc=none smtp.remote-ip=209.85.210.174
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8D5606A32F
	for <rcu@vger.kernel.org>; Fri,  6 Nov 2026 12:19:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C8D5606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S1eGr1gU
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8a070755c8cso215807b3a.0
        for <rcu@vger.kernel.org>; Fri, 06 Nov 2026 04:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793967540; x=1794572340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z0rdYCKEnZd8FGC567jnfce1H0VjvyM0Z9c9ULvtLp8=;
        b=S1eGr1gU5UIAutMHpkWC1aUMSI4CEMF7L3R3nwu1e5WUKRFZPMlmR3xDe/QaWALFQz
         hH0lKvZukdfuMwbTRhBdo/Z+HdG4nC0uKX0IlcqDmHuudoWPqUTnSJImgd0bMypRkqNU
         142k69uxCFrlCPGAPiyolqh258x/C0LwVLhheWce1ap5UTlCuvIWQ3etE4qvn0gE4rYE
         SMEV/OCndFZVZkhwjFkkbRcO/T7+VLvczw/C5rDzVXqD7CMQt9rlxk+DNiPjhXjwdIuS
         YVGCQjLeVQPqULyVdR5SUe33vYLmed9b7vHj11SxkheMqfETiB3YLycGu1ZP32sDYoVk
         0ngw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793967540; x=1794572340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z0rdYCKEnZd8FGC567jnfce1H0VjvyM0Z9c9ULvtLp8=;
        b=LWtsqc24fJO4J7pmcA/qQGPpKgrg2Q9gTTfuNEbs86fjTOoV/3J63u1Tgv6DdC5IhW
         gDPYOdgxTMcxQIk0GREkncchVsMO7HQEweIMiRRpJqXcznQWIEpCGl+CELMfLjJWquum
         n9iH8FAvtWLezAPVrSTNyL67d+OhMaAEMdUnK6G85aYlDGT/YqVCkTYmkdjByljWy1f2
         +VSTXQflzVfY0jsB67iMOJHgWa6YN6vcbV25UeNnpHNXekqHeVhK8WNFDJ7pmJzkOR02
         3Oe2v/JDPIOH+aPBX6wNLpKlXDfPudaCFXWa+3ka10Hx/ORnZn9vIZuSBvxHxX4LBwfn
         7YFA==
X-Forwarded-Encrypted: i=1; AKwUvBxn04wWZIrLdLc0KWDQZlxiJgMd7q0tmoZZ7CG1/lcQjTcqdBBfCG1/x2Q9mLl1q/BESkk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/o29WFS+REzucJhqlFaImdYCszEzgaxfpa1hpHiWVEetGxcG2w
	YyP5a5mLyfl2ev5JsRzqKjI5vT6HmWecEcWN525Wg3PoTxj8pfUkkXbs
X-Gm-Gg: AYBFou1JvhLSY64Zwic1nlJ+jbJjzLBPYtDhgQvR12RyyMgPDarU10jR+uoeNHT/Z7B
	ym5QnJlHiJAWJCtJqb2K/VQiT60Py/kacVxDYCn4pKq6P1HuWs4JGaQbV1+MQ5zCi2gumrD0rrF
	inRgmEBHXhVcjqYmm+tYkIOw6PljYRkP7ZIwA4+CVsWI57v4zD/bhL1JxtXALtZzwCT0hzjfSkp
	e+P2bc5KRHltjJUE01BRkUJhDU2+HLjhfI41s4Rx2rnuacQDlI+k6Ih2FDnKJQXpcOqnFWqvEtm
	A3oRc/WGdmGAJqph6cUYL/+NZLGMMRBjTbUj4E1DPWt1wbgzYdR7ZXeD8gcMp0rlRFIt0nBAbLR
	6QkUlvw31K2tWYoZfh2800F9rqIKHdB7nH6bO069otFPMNFp24UOFM2fLixXDJxXBkNCP+cDzMs
	FB2LZRD21SF9QVYZr4pMdHhdWfXyLm/qP9LVxjIHx4Jnxui+Tu0xAy+HWKepZxPwsQ8yCSerj7a
	vZuPYIfSjhW6BSnrOTAey+XqcZ3b2AVcNLiH339SM8RfWF21O0x19IwQA9JW19/8hQUXpKjAXG0
	LaaPb/U/B/m587DQD3h2queGhkzuvsZgSqW8fwxWdsnZwoh9UdhArMvrsHhxB389ky4=
X-Received: by 2002:a05:6a21:2d98:b0:3e2:afda:c37d with SMTP id adf61e73a8af0-3ebb29a4f9dmr2641715637.60.1793967539621;
        Fri, 06 Nov 2026 04:18:59 -0800 (PST)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb706494d6sm517562a12.8.2026.11.06.04.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 04:18:59 -0800 (PST)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: vbabka@kernel.org,
	harry@kernel.org,
	paulmck@kernel.org,
	qiang.zhang@linux.dev,
	akpm@linux-foundation.org,
	hao.li@linux.dev,
	cl@gentwo.org,
	rientjes@google.com,
	roman.gushchin@linux.dev,
	linux-mm@kvack.org,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhanxusheng@xiaomi.com,
	Zhan Xusheng <zhanxusheng1024@gmail.com>
Subject: Re: [PATCH 2/2] mm/slab: don't queue the page cache work under krcp->lock
Date: Fri,  6 Nov 2026 20:18:52 +0800
Message-ID: <20261106121852.3124703-1-zhanxusheng1024@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <au2fUYzBLv3uvj_2@milan>
References: <au2fUYzBLv3uvj_2@milan>
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

Hi Uladzislau,

> so we forbid zero as value to use?

Yes, that works as well. The parameter is 0444, so the clamp in
kvfree_rcu_init() covers every case, and with a delay of at least one
jiffy queue_delayed_work() arms a timer instead of queueing the work
under krcp->lock. The check added to run_page_cache_worker() would
then not be needed.

Thanks,
Zhan Xusheng
