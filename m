Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AE035E953
	for <rcu@vger.kernel.org>; Tue, 24 Mar 2026 21:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774388124; cv=none; b=BUfaLRNEseoH6Oxtnzq3gK7QDzeI9AW5AVPr0i/hVCipRXbGlNIdB594pKJP5SGkb9Q20Ffp5wZM9H0NPJZu8ZS3Gaklp4Vsxi5So0G6Tpen2Y55u1dGxEM9Jm4hPnRVyG9dumHSU5fGw1PWmlETCdV+tH8DkYn0Sjd+WsHqUFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774388124; c=relaxed/simple;
	bh=usnnnH7wUGYWY5NIsmoimFYx19G6HqPPrRI2oZAKt1Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LWG1XS4pmVO2X0ShWo0eVp+GHz5wkM5DcwHsosCYA9/H5U9mDVCOezAXz76221Wh2//BbV+rIahjn3va5jLxvQ7QlUJC6UR1q2A6AN6GTbLcFnycvgGAXOJ0yp2VWBOSZmZcfDh8Knoqf/sbUY/+7ZR19HNaaJ5dli1OhzJGqDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=it3ihn2s; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="it3ihn2s"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-485317b6bd0so9935e9.1
        for <rcu@vger.kernel.org>; Tue, 24 Mar 2026 14:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774388121; x=1774992921; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oT0RY53ohSbpUHq/mckzhfzjGE6xK7YwQGcozbaC4yQ=;
        b=it3ihn2sDWKB1ql3gXeIWqC/IU8Oj5Flmx4dRnelBk+Cv8FHjImkdpbfmGsD4/r/Ar
         f4eW7B6KDuJDfjgzeLkrALFEcA8ReWuv6GSl6mEqxJMVCQnJEi6wNJBjTXFIVdDlFTiV
         fGhur+nreGDwrcKYDu0O+gGThWv+o4d5vUMKcM0YH0OqwRUQmIHX/Sxj42Oz0ycqej/n
         Fu6dRohbvEinESvVzJstHskR9tV3yiInapUaVf2zYpi7BSXGSUhaz7913mpp/hLDAPMk
         9W7eHvE9sxv1e5/7Sy3Lol2X6xZU02R5OT88GkJq/9nM3o7SLjJd3Jb0w3wydjCNycsF
         NLTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774388121; x=1774992921;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oT0RY53ohSbpUHq/mckzhfzjGE6xK7YwQGcozbaC4yQ=;
        b=LEZhlVUqCa4VCaDEhuRVaNW/SXgFTf0PNoSo/uk6AbvE4ysxYsBkgrMSxR4Uh7h0OQ
         hUYMBJAGQ9qvM7WGspqBtmyvNdBSuOc4xvYqVBN4M4dzYcpi6w0iYwQLJUYe7BHlBCr6
         72v977KDKzOKuzbW21hAWu9fnKcpj6RMQ9u1qiwdyQ3Cd/8MBe36X1Pzhccq70HZVR38
         U5l+oJUpPVTL/KXQeHGRpZx8jH23PtlRByV+7nMzItXGLfXYNa8Us34JwHTxQO35sWHP
         UuIgRktquqbcaxD41v2lIItqEncLaZDDFgLy3M/nvxQYPsa1I/uQpB8Ena7q/tAzRLtW
         teOw==
X-Forwarded-Encrypted: i=1; AJvYcCUSpFxNZLiOMQwstC1QQ10Pj4MEbWGhF7TovDVcmWFtMSe3BASOZkYDWc7HUOpgJ7En8lo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7oHG9XH7SQqXC00zoImC4hMzLH744yjqOQ5t5Q1yTz6qSReZD
	gKCto13XAmpLNIibSEI2S5tGXO4Hpk3KTsVTfRzWD01xAYBasxjuLv7jwLCCc8uRgg==
X-Gm-Gg: ATEYQzxQ1awbJdM3QZsOBa+jDPq0qxR5peoOyNzTl8JumOjql+nD+Zmw9GfZFkRbu2a
	oL0hqpcJYedk6aBxrUxjmIB2CwwtC7SU0R/Rw43gbrjd7k0Pt33LjBmYmJHSj4I/XeyzaCDUbaJ
	k4AGRuSSsLtDw/iUA/iilDrNE7sLMufkUrb0476+RUXPN9hdAHDgzHO/Q/4/h8EQ3DhJ3y16VsP
	7eCVneiFIsihUYak3pEQduNVU8ttKSumdZQeHwuhSwaolGhWrud6L3H58OOeEm4asFgugt2REAq
	fd67XhnWLhHnbVmFJ73+ueq4jdZvBe9NERFA5H5vibzNFHIWMSiNFyhKf9xSrpf5kSNJd5E4AUs
	e9bi3ssK1SYAg3i1d+ewkY/cNRqVUzAdJ1vSbMPAze/+UimrHmCasBhyHHyywgjNsccFlnHB+Q1
	sDnUjvdA0PcMY4b7ND9Ke0ZtY5YjIa4GAnUX2TiCIPtJ08+RkbhW6d5LENd3X7EA==
X-Received: by 2002:a05:600c:c1c8:20b0:486:f772:91c4 with SMTP id 5b1f17b1804b1-48716819f7emr188615e9.8.1774388120569;
        Tue, 24 Mar 2026 14:35:20 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:ded1:e23b:8c0a:3b21])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-43b8aa474b6sm710974f8f.10.2026.03.24.14.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 14:35:19 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Tue, 24 Mar 2026 22:35:12 +0100
Subject: [PATCH] slab,rcu: disable KVFREE_RCU_BATCHED for strict grace
 period
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-kasan-kfree-rcu-v1-1-ac58a7a13d03@google.com>
X-B4-Tracking: v=1; b=H4sIAI8Dw2kC/x3MwQpAQBRG4VfRXbs1xkS8iiwm/uGmhu5ESt7dZ
 PktznkoQQWJ+uIhxSVJ9phRlQVNq48LWOZsssY2praON5985C0owDqd7NAG1xlbtwiUq0MR5P6
 Pw/i+H49oAKphAAAA
X-Change-ID: 20260324-kasan-kfree-rcu-4e7f490237ef
To: Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry.yoo@oracle.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, 
 David Rientjes <rientjes@google.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 "Paul E. McKenney" <paulmck@kernel.org>, 
 Joel Fernandes <joelagnelf@nvidia.com>, 
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>, 
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
 Dmitry Vyukov <dvyukov@google.com>, rcu@vger.kernel.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774388116; l=1651;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=usnnnH7wUGYWY5NIsmoimFYx19G6HqPPrRI2oZAKt1Q=;
 b=SgmquGvg0X9VR0OP0g3btEDHfyjT6PMsoHAYVyfCmCV0ATxqjDCX7hohdeoRiLQJIAjY7BLQY
 dwd1J12BZ0kD7ik8LI0ZUha0325jzs7B3OE7eJaqSFXoG05/MNUX12w
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

Disable CONFIG_KVFREE_RCU_BATCHED in CONFIG_RCU_STRICT_GRACE_PERIOD builds
so that kernel fuzzers have an easier time finding use-after-free involving
kfree_rcu().

The intent behind CONFIG_RCU_STRICT_GRACE_PERIOD is that RCU should invoke
callbacks and free objects as soon as possible (at a large performance
cost) so that kernel fuzzers and such have an easier time detecting
use-after-free bugs in objects with RCU lifetime.

CONFIG_KVFREE_RCU_BATCHED is a performance optimization that queues
RCU-freed objects in ways that CONFIG_RCU_STRICT_GRACE_PERIOD can't
expedite; for example, the following testcase doesn't trigger a KASAN splat
when CONFIG_KVFREE_RCU_BATCHED is enabled:
```
struct foo_struct {
  struct rcu_head rcu;
  int a;
};
struct foo_struct *foo = kmalloc(sizeof(*foo),
    GFP_KERNEL | __GFP_NOFAIL | __GFP_ZERO);

pr_info("%s: calling kfree_rcu()\n", __func__);
kfree_rcu(foo, rcu);
msleep(10);
pr_info("%s: start UAF access\n", __func__);
READ_ONCE(foo->a);
pr_info("%s: end UAF access\n", __func__);
```

Signed-off-by: Jann Horn <jannh@google.com>
---
 mm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/Kconfig b/mm/Kconfig
index ebd8ea353687..67a72fe89186 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -172,6 +172,7 @@ config SLUB
 config KVFREE_RCU_BATCHED
 	def_bool y
 	depends on !SLUB_TINY && !TINY_RCU
+	depends on !RCU_STRICT_GRACE_PERIOD
 
 config SLUB_TINY
 	bool "Configure for minimal memory footprint"

---
base-commit: b29fb8829bff243512bb8c8908fd39406f9fd4c3
change-id: 20260324-kasan-kfree-rcu-4e7f490237ef

--  
Jann Horn <jannh@google.com>

