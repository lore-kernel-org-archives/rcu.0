Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516A344B663
	for <rcu@vger.kernel.org>; Thu,  7 May 2026 17:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778175444; cv=none; b=dUcEmzn4emQa9JaXOCcPthOuJBzavbJljvlc9AZy4JbhblwYczgucgDJmErsiJXQ4crg6qoKI4J26yUR0+28U5XEVt0pd8QXuWuCJjbYns074mzQNQt2rN5d9w7kAMCBrUXlnKRxQmnYygkikqfLO9uZ1yOioZz3G/MZssXyBcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778175444; c=relaxed/simple;
	bh=iQJr54WegmPhbUAbIgTUeyQ8ZbpA5vvEo+qg/1ZRgQE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=G3Yn6n/nagLeNGIO8RFJ7KS/qJNrAjyQLZUmr6bYUlL6oNP5TOUiXixfBqX7pT9gmqCfNwWJl+aYE8TLdkNRdP5RntKZBMXzANmWP3wM7LsP12KCExYMYf+nqVuQbOE4PphPPeKKI1oTSCsbO7P2MgLFbTfRjXRnqDeY7Wyb4gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h/pvfdSR; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/pvfdSR"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-44c44af71f8so135913f8f.1
        for <rcu@vger.kernel.org>; Thu, 07 May 2026 10:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778175442; x=1778780242; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=INZOC0Dl4Lw7fXNJfSILZ6zRGX9c7famI7AzEybdCC0=;
        b=h/pvfdSRA3y/EQbziaUCZrlAxr1dZHh6vVlfm3UUWKgV6Nott+EFerDrtavyV/ASU8
         1Y2AnT+O0zs5eFlPmv5dTnsg5NunpCJpzs2EP/Up1mca/HzHupjKBHQDIF84wpfEoO/V
         NdaY4is9r9Z5A6+aJ9PMIC1bUIDOMzqi/DgZJE3VXZtUz6n6eJYb8qUkRcUAnTxhEsRD
         c+9DuZdiMTZNb0eaOnzDHJ2YFQjY5Q5bp7udpuIlgWL+wIYM/MfECOKq/wtTe8agvfeP
         pUsXWne3XTFHljPLJQtKKSu9n1WFCUGdTMU249W17fXAsPDVcnrDu4onlS6KNhi2PKfR
         uc3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778175442; x=1778780242;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=INZOC0Dl4Lw7fXNJfSILZ6zRGX9c7famI7AzEybdCC0=;
        b=YWrrYGJ+OKonjPumghJnMMpy8ecBMEKfuU3OHSflZYJQ3dK22nVWKKDnHoLlE08IpP
         po332xMf3deQq0hkp+Y+e9YabhSYK50Z5QYyjVPRZjuf57yi7Erhlos6DHNtt++Mj3kl
         r09XFOdUGVZg7ZFl60EvpuskV8fOJHzazw1mLqCIRAHMLHrOWFi8rDnmjWlMpRwfHJrw
         bD1aSNP0E+5siU2BG1X4DFml+stsDeMSO9zAij0X5LmKlxXmPrsnM524EuV334/5stkG
         kLgvKl8SX9PPvH3JWJNjjDyNIzT0MHA+Bo4ec8UzrHkOAyAoOZRZEXJ3rRU21N9uJqZU
         FLPA==
X-Gm-Message-State: AOJu0Yz1DvbeWYbXahkD5xlhuIah6O3oU7WZd+LwRpfHNij6TPL4teb+
	aYj0fI5vib3P+050MhkvsvqCVjHQ4JwpL3mGYglDMqaHsti/TiYQffdi
X-Gm-Gg: AeBDiesDMON60nb3vFT3IEXnMnDrJ8joasAfNTHklb2ZAFGJwjZWwpFg/Xdb0/6MxkS
	U326Wx5NHRGJ84LBuOUKdDhGn0WqLx7AxohSPZ7QMSNAxv14Jsvn1rOsCT01HlApFcL3beHYlSP
	su66cA7fmP4yHZa0mM0lx862byYqXxlEnYZoN/lnsW6qnvmi4BqwcdhMOI04yH13TYxHckpt+dm
	Ze8g+w+JTbx8LZb9MH35IS6mhUhSITmHXdcsKPgkYldQ2AbKIJU5bAE3/q5KLLcjeIy4GgK8+XH
	bo4IYW4pogeuuJG/+taA5SIQQxuG6NTUcu5fn2/Y8aFJEyr2+Gntl89Wjmmx/Vk6utJZyQVIejU
	3D6O9EFz8fBgKnTCSKSaKyGOlf13qBOAtvpkgZIaZBxHPQp4vHoTHG595+TRhYlr4yQKy0IDaZo
	e9XguUvq7/s71cFiGBhJILlYEiTJRu2OYc762FAg==
X-Received: by 2002:a05:600c:8b16:b0:48a:5758:7999 with SMTP id 5b1f17b1804b1-48e53293f81mr63501035e9.4.1778175441163;
        Thu, 07 May 2026 10:37:21 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:2b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e5390f854sm133308585e9.14.2026.05.07.10.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 10:37:19 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Subject: [PATCH RFC 0/2] rcu: Add debugfs interface for pending callback
 monitoring
Date: Thu, 07 May 2026 10:37:06 -0700
Message-Id: <20260507-rcu-pending-cbs-stats-v1-0-8f4eb3553bc9@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMLN/GkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDY0ML3aLkUt2C1LyUzLx03eSkYt3iksSSYt00c6M00+REA2MTQ1MloN6
 CotS0zAqwudFKQW7OSrG1tQAfiBmzbAAAAA==
To: "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
 Joel Fernandes <joelagnelf@nvidia.com>, 
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>, 
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
 Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>, 
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>, Breno Leitao <leitao@debian.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 Gustavo Luiz Duarte <gustavold@gmail.com>
X-Mailer: b4 0.13.0

There is currently no easy way to monitor how many RCU callbacks are
pending system-wide. The existing trace points provide per-event data
but require active tracing, which makes them awkward for fleet-wide
monitoring. Knowing the depth and stage of pending callbacks helps
admins reason about RCU health, gives an indirect signal of memory
held back by RCU, and is useful when tuning RCU parameters.

This series adds a debugfs file at:

  /sys/kernel/debug/rcu/pending_cbs

that reports per-CPU pending callback counts with a "total" row.

Patch 1 introduces the file with per-CPU columns for each segcblist
segment (done, wait, next_ready, next) plus a "lazy" column.

Patch 2 extends the file with a "kfree_rcu" column reporting objects
queued in the batched kfree_rcu()/kvfree_rcu() path
(CONFIG_KVFREE_RCU_BATCHED), which has its own per-CPU queues outside
the main segmented callback list.

Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
---
Gustavo Luiz Duarte (2):
      rcu: Expose per-CPU segmented callback counts via debugfs
      rcu: Include kfree_rcu/kvfree_rcu batched counts in pending_cbs

 kernel/rcu/rcu.h        |  1 +
 kernel/rcu/tree_stall.h | 72 +++++++++++++++++++++++++++++++++++++++++++++++++
 mm/slab_common.c        | 18 +++++++++++++
 3 files changed, 91 insertions(+)
---
base-commit: 8ab992f815d6736b5c7a6f5fd7bfe7bc106bb3dc
change-id: 20260318-rcu-pending-cbs-stats-f72f5ca03415

Best regards,
-- 
Gustavo Luiz Duarte <gustavold@gmail.com>

