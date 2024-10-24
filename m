Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3B5146D6B;
	Thu, 24 Oct 2024 16:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729788364; cv=none; b=PiF9yp4FDUKErk/zS7JVgyOD/3gkeTxCOpZyGLBWyaW92yNOOQ7Wvj7CrqRgSkT1Fcs+k6YTRpAgnirZcsLWN9ne/+TlzKnt/SUPG32UxHYCc3NDIuE8LjGUkhHZB7NEr/pa8/YKlTKkmpEtkA9bj7YlqoOYoiPDHqlNLoBpcAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729788364; c=relaxed/simple;
	bh=6RvWl7c1Blf+pKLyH14JL0eqSFnZ0IEsjbDt/9iNkec=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=vFlKFMCBp7OHVv67NdzRH3iVHGPoCkZ7Y3mSGLZ/Im/jnhKk2G2aNUt5qmWtSwpB9mEA7WEmznDyNfZrl1rNKWERsFLj2tdKdGfUCp/CzXVh7ZPQ9XDzMdqCNn6sfsW3EaBB5xY7Ql3cWu0d59WXEHFP/UZKw50PEsDOo7Bo8Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bL+BwL7P; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bL+BwL7P"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2fb5111747cso11832191fa.2;
        Thu, 24 Oct 2024 09:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729788361; x=1730393161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uhSLd/uSxzIvIOYAGFOrbEEY03TTtAw8nQrdW4cMQ4c=;
        b=bL+BwL7P5D7gPmudupydlaflSObb4wf5HWYm1tKXodNs50/13vHVtkgH6sgQQbsHrd
         PL4f8Zn5N/6UniUgSdObVIk1mH667FXHMJ2IwEpuVa8YTo7EZlKhsN1PhZtmSFBB06wm
         afptHIF63isOp45hp/b6NlQckBCWFkdGw4Mw8+EkUcxNxvOY4xmVzSxA/0ebwHce1ZIn
         pfRYzSs/zEToC/hqtaRUd05+5fJ7vZEWwA+KtnmdJIZ761zQzQTzArhyd5F5Y3JqbDn8
         boTF8eX2iLYEBXdlpqJLRll6FdEzSJzh7raK3opo2WKY4Dy1TJkhd1uaVNufZ6EdIj03
         paKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729788361; x=1730393161;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uhSLd/uSxzIvIOYAGFOrbEEY03TTtAw8nQrdW4cMQ4c=;
        b=YwSbPaiVTLoIPheSAc6OJTbZ7SHpCcEJrMM4VrLzbIyEUz8nlJJDeUAhuQ9bBqRgHt
         1O3E0Hj2A0rk1w63k5We4p6X59wdrSNNbpNPnnZ7tmp7M/s/GImK68gJuHyRKjjH2eJC
         qDogbWPc5XqbGi34hBWFaZAoobbtziIDb3wzM3ZrKvEKwzQQbBBA3dmtR/+CfJCmdQg3
         tWefoOIUWKpu3HSHdi5BGMMlf6sRT5eSG2u/avKJPuRRMsP4JOhdYjJXT5iRIkyWcKya
         wXkxLqPyKbFqLMKf6zuiEUPmzjzpGXevu6qz0Ap98XifCZ4l6BdOh1u6IHzKJxlzctdG
         ZL/g==
X-Forwarded-Encrypted: i=1; AJvYcCUxM46aNT95iPgn7xLCEB0S7bB05r73tjONM9zpgr16qWPayvZfh3Prc8a0hvP2tpaHTJHA@vger.kernel.org, AJvYcCUyNMiTgVakAa0R5n5gEVXiYJ5BOLjy8x0KArzYrb5Ys3vP7FL+Z/0e47VIvwEIdfsdvgjm2c46WFeUfRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOORG2Lmro+7YEdufvc8na4hRF89F4JTyq2p1k1qSzqIe+lFjV
	OmO0e0921xeKGN9MkcvKg8LG6t1K8CuqdKD3kwFpI5KdE5FT6wss
X-Google-Smtp-Source: AGHT+IGfWiOIgWicZJQJSEQPHF1o6O10CBKLqOS2aocUloEjDgaE7pk6GexUsoRMwYyInymkKkDGQg==
X-Received: by 2002:a05:6512:2304:b0:536:54db:ddd0 with SMTP id 2adb3069b0e04-53b1a2405f9mr4674475e87.0.1729788360234;
        Thu, 24 Oct 2024 09:46:00 -0700 (PDT)
Received: from pc638.lan ([2001:9b1:d5a0:a500:2d8:61ff:fec9:d743])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b1f2d17b5sm441967e87.22.2024.10.24.09.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 09:45:59 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: "Paul E . McKenney" <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH 1/2] rcuscale: Do a proper cleanup if kfree_scale_init() fails
Date: Thu, 24 Oct 2024 18:45:57 +0200
Message-Id: <20241024164558.715296-1-urezki@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A static analyzer for C, Smatch, reports and triggers below
warnings:

   kernel/rcu/rcuscale.c:1215 rcu_scale_init()
   warn: inconsistent returns 'global &fullstop_mutex'.

The checker complains about, we do not unlock the "fullstop_mutex"
mutex, in case of hitting below error path:

<snip>
...
    if (WARN_ON_ONCE(jiffies_at_lazy_cb - jif_start < 2 * HZ)) {
        pr_alert("ERROR: call_rcu() CBs are not being lazy as expected!\n");
        WARN_ON_ONCE(1);
        return -1;
        ^^^^^^^^^^
...
<snip>

it happens because "-1" is returned right away instead of
doing a proper unwinding.

Fix it by jumping to "unwind" label instead of returning -1.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/rcu/ZxfTrHuEGtgnOYWp@pc636/T/
Fixes: 084e04fff160 ("rcuscale: Add laziness and kfree tests")
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/rcuscale.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 6d37596deb1f..de7d511e6be4 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -890,13 +890,13 @@ kfree_scale_init(void)
 		if (WARN_ON_ONCE(jiffies_at_lazy_cb - jif_start < 2 * HZ)) {
 			pr_alert("ERROR: call_rcu() CBs are not being lazy as expected!\n");
 			WARN_ON_ONCE(1);
-			return -1;
+			goto unwind;
 		}
 
 		if (WARN_ON_ONCE(jiffies_at_lazy_cb - jif_start > 3 * HZ)) {
 			pr_alert("ERROR: call_rcu() CBs are being too lazy!\n");
 			WARN_ON_ONCE(1);
-			return -1;
+			goto unwind;
 		}
 	}
 
-- 
2.39.5

