Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792573690;
	b=ddZu9p8g69iFexrS+S2DnW3vO4UFvzYsFoN1HKFu3qQJJmM2kiJ07bKe/WRX07GSEZP+
	 uErZ7Hya9VFxFwuqGnI39Itnu/kduORTC3eilm+P3arzOfuDXEcalILO8M4DX07+Qv2hA
	 fseju+9YcdVKb7zaCVdttUHE9L5q29gMFbNkASTgt3Pft+aPxtR6RkABg7pr9/AztS/FT
	 +7h8B+Dj0XM9P7ns67+obgrUKzTqe8zoFSKhCj4QNArfAivzcEzi29jmVvOjJSxQTTLEr
	 t0TD7B5os5IV7n1XY6VmYvsF4beZijg9r+ZGO7cT03EPX1m06fO02Qega6FXDmB7VrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792573690;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=G+YdeE2DDW/sG/hZRTEma68Ws9O1RV/eZD4NKv++fSE=;
	b=GCF4wBpfLyU6dC6eAgKXriCG8LFNvQ2skpVQi8o/qJzfb3hRZ/Zq3JKtwgSYwWhciEWV
	 Oz7BaLy8vyfyKtD6SiazGK0hrYJI/R7a74ilco+lBa7Kfvjnk0UK12yG5wFXsIrOx1u2d
	 sg6aP5gg/sYFnsIQfNF1DZ2F5fLyPYmAtQgawN4/FxiB0j906FKVo7m7DgfX3Cp+IwZtT
	 tT8RA5e9QLn3sk6r1RhIo4wXHNmUErJUeuN0w76ikz5SsriGddEN4pfkclFrzyDp4iaCh
	 BvmFazfdhH0eLepbT3f9b71Nk8GefPuuHg7NkGuAq4dgVueG8lJp4dZbFR5YuxfrMVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=X8jdiDtV;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FD4606A31D
	for <rcu@vger.kernel.org>; Wed, 21 Oct 2026 09:08:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59FD4606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=X8jdiDtV
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso3746275e9.3
        for <rcu@vger.kernel.org>; Wed, 21 Oct 2026 02:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792573689; x=1793178489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G+YdeE2DDW/sG/hZRTEma68Ws9O1RV/eZD4NKv++fSE=;
        b=X8jdiDtVWw7z1fXMCdPITt4sppvby/X8rOwKYiGl9SwuRJ7t3xACyq4L8Y2Yqupjys
         jBzWwYdCAJhQvL8EvMt0udi3cqtRdx2zddI30f3048qq4l9yLm56nfbTkTxZzMY64Qub
         zNilY/8hryW7gJdSCUNQByUKN5SI15AiH3porNbvtoWbmns1eblE9E6/pzzP9E24iWH3
         UD3/IvIwl8TAUGLMrNqAzdAY3GXuKtxRmtvSPWXzBeDQVI39hi7zauHx1d5fUqQuetkm
         UCA9Xo/k3mcZPf5guX7OB+cVPbjvnlEtC4HgP4p1LR1Z2XcMttYI6DKl1O3rnxspMNnR
         vMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792573689; x=1793178489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=G+YdeE2DDW/sG/hZRTEma68Ws9O1RV/eZD4NKv++fSE=;
        b=JKyhmodpKpKOPRj7h6K0dDPMkil1MR48pS8SCpLnrbv1YehJMdBT1qCzAW44/5V6/N
         pqB1/dHv7T42hEfyzcy5yvb1Zns+VAtfae/vw1S6/w1KhgrMDKzZfeZZ+QG6CtxhagA/
         gdf8RWCoou6/PWNUp+W+H8QZtiSdFuaM/RyJHtUHfWUYn5hJWnTtDG5kDYL6pVwjxQfj
         w+STf6PK31lTMzAamuXvmu6rRy30AUiHnjFYxbX8/vWYuuKietOg4RG0EqFO4GiVn563
         gENTX0KxCpKzdviKzKJToLvz3p3+T2XHdKCYtMJvznVQ/vJpLAKMJksO6c2ZeZrUojH0
         Kssw==
X-Forwarded-Encrypted: i=1; AKwUvBwuMyNdqTifairZcwWRuZiYAjnM/edBRJfsx8RcNr7TnnH1LQUafG0KyTwssKR7Cw6bmkY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJAeQcMA204SUTY+k4eJWPl7Hb5Pi3YPjjnq2VL9d4bPEVE6gP6
	da2nYpuNYQHZp1p1ssK2fg33eNLLtT9LfedrshyADlat9Rv5fHu6Y6ip
X-Gm-Gg: AYBFou1kskm+EaaEfo3PbA2y66G4cUWywLLrPbNquuJhQUES/naT+cBi04eSmECUf6I
	wcjxryO7sDLL+8cpFsqS0cuR6rF+VVQnBy5TUL9WSzO2VRaiTnj5f3ikWKy1XEKqbzHRCQ3ospJ
	a0kyazgQs6QrBZWR5Ej71ahzKy0meu2bUL53bx+rc8z5unW5p97Mzu5iyjNl1OKqF8bmsG6MmK5
	z5ec89V0jQ3c6FwJsN5ZsQSVLi5ny0YeTqHzvutDneA8Pu2Wf402ODGBPRhW9Nbv4RA7VrGdjTc
	G5Cnv1yFTfZdsPEX9gA9ZMPMk0WIyree3DViAMM+Fsb45JyWc6XnToTItPW7VVV4Cu/XIL9JhgA
	Z2nPMdL9TzwoWK6grYCNzKe9xbAprungmhlJ3PNk4wDCOHsjqh84/e0O7zMrwLdZ2kdkO5Hm80Q
	9Dta+3wDn7oAi21nmiCQZbfK7Wk2OPQ74OzOcZGBbQaGESLwgoOzTZq4eBu0xJ/9rG+/ED59tJR
	3c9p5243uweaXLMx2imwUUi1vnbDsXusrSZiDtnBo/JbFRu1in3uVBdGUrfFV+nZp2mgD6wGv8e
	P982oAQiU4cQrZRGCGmMvEE3mpXAvap81D4I1H2n+Iv3kA==
X-Received: by 2002:a05:600c:620a:b0:4a1:706f:b40d with SMTP id 5b1f17b1804b1-4a1fdb1a609mr23289665e9.7.1792573688575;
        Wed, 21 Oct 2026 02:08:08 -0700 (PDT)
Received: from andreayoga.wind3.hub ([151.76.51.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fd0f4427sm35401565e9.3.2026.10.21.02.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 02:08:08 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	Bradley Morgan <brads@mainlining.org>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	rcu@vger.kernel.org,
	lkmm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC -rcu/dev] hazptr: Record per-CPU slot owner after claiming the slot
Date: Wed, 21 Oct 2026 11:07:52 +0200
Message-ID: <20261021090753.20442-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <fa16d2b1-594e-494b-8cfc-9b8c13f2c223@paulmck-laptop>
References: <20261019161852.12783-1-parri.andrea@gmail.com> <4defa4de-ab42-4809-9645-100cad68972b@efficios.com> <fa16d2b1-594e-494b-8cfc-9b8c13f2c223@paulmck-laptop>
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

On Tue, Oct 20, 2026 at 02:12:09PM -0700, Paul E. McKenney wrote:

[...]

> Thank you all!  Queued for testing and further review.

Thank you!

> Andrea, on your KUNIT reproducer, is there any chance that this code
> can be folded into the existing hazptrtorture.c work so that it just
> gets tested automatically?

Yes, though not as it is: the KUnit test relies on a test-only hook
in __hazptr_try_acquire(), which I would rather not add to hazptr.h.
hazptrtorture already has the interrupt side, in
hazptr_torture_acquire(), but its readers rarely reach
__hazptr_acquire(), where the race is.

So v1 of the hazptrtorture series will add, as patches 2 and 3:

  - two CONFIG_HAZPTR_DEBUG checks of the recorded slot owner, in
    hazptr_release_debug() and hazptr_note_context_switch(), and

  - a nest_acquire module parameter (default 2) that makes readers
    take a second, nested hazard pointer through __hazptr_acquire().

Without the fix, PREEMPT and NOPREEMPT then report the race about 6
seconds after boot; with nest_acquire=0, they run 10 minutes without
a report.  The nesting costs about 30% of the readers' loop
iterations, so it could instead default to zero and be enabled from
the scenario files, if you prefer.

Thanks,
  Andrea
