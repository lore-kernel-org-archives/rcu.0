Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A46326A1AC;
	Fri, 28 Feb 2025 12:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740744843; cv=none; b=sBZRL/fvZG+lf93z19dAZaLk1iacYlnYLs9bBTOL02TBowPFsOax3LxoJKq8fJ2JVuJP1fHx0JWOZ2eyw9xhtlQK2qbYBJLUsJPLZiiIoKNG1T5+mnkUNu7As4JqNrYgsqdeWIrqUlbi88LcETRKJ1olIOzn+gJyt3nDnM5Wubk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740744843; c=relaxed/simple;
	bh=tnfpMuVm4VBQfp3yu7qk3PMClI30zaEI7FgcpejGHl0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nJZ3we27a8HZmODx8uzGgXVTPiu/pE6z/trBLHtkGXsE99gMz4LKoTMSUyl0aL5Hc0hgvnzJnM8NDf9WD0I/sMBPXnsRri429iQHfskEruy6PoKbW2SDAHwtTUhaRRlaxBkviktuWrRhP5//brwmWtX34mPXxXd5wANlHGHcca8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QMd+9NV4; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMd+9NV4"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-548409cd2a8so2084383e87.3;
        Fri, 28 Feb 2025 04:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740744839; x=1741349639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pkAygyolNUDpTR2GUn/c3jGDRfvql77S9asYrw4dJlg=;
        b=QMd+9NV4zsHqGHL5LRd8KJZSEJgfNUm61jvgygievHKi362sr1maqrSjLAD7tcj7m4
         cVy78bEBHcAnuHp8KigNLg0BoY4jWwpYFC6lB+QfocQtu4ll/bWRm0ygjoRLGcRb6CM5
         3+ZQVSrv4S4WGzDT52VlCdVjglurvytVKkJx5jzgLpfvWD+YrBEej9IwcTTHhz9dQAbC
         FEHYtigvXubjPl0O4eczBUIbJkT6immXod3mHnxNtYE+1BZNn0IE5aV2fcjErPSCDtbA
         4iak+uRwMOUwnQRcd6eFStbofaAwxmGiQIXM3Lb0lh1Ei+AI08buw2kSvbYc7H83kgtc
         d0oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740744839; x=1741349639;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pkAygyolNUDpTR2GUn/c3jGDRfvql77S9asYrw4dJlg=;
        b=D26PFPi27Eiaf4XWqga5aH5fpfbDYDaw2ZMbgNAtl+EHwx2q2F1oHl6+8DkxVRFk4N
         izsmqY5/mF1v0lYLUlJQ3nCPdmuhU2NuTNj4IfbVjZxpr3dNZhM3lWpxa3NXGRi8MLuY
         xRvCOme64sfkVImevZ9MA0aJkkQ76HRMuceMgOgCkvUEDIDBCAhVkRcaRBNP2SSbSgIv
         cFVTQZCrNEnB6RHEWofKsowS2YqUxEoC2J9QR+/cQABqr68AFHAKikTFTSSq6fwBrGtA
         RlmXfv/VZtUME5SBQKvEIQxgYKyRTlfqI6LMq+lCe0iL6HX6ixCXbLlv/ZUtTckttCdE
         7n3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUASeW4yxlRHL9WdfoKbzn9nNSU6a3/M4uA0xw3eGTxLZdHPf0BQVxn0inDSmr5hX8QcXujtV2XPoljx2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkR4F4mDCgsS3AlEGPxvO6rYw9fW9DVd67/wDtj/Vhi0yDfaDO
	VDpca+FqgH8XLrpZipxxv+BBe3IUX7nK9bXsAA9qWYw+s/UjFxl/
X-Gm-Gg: ASbGnct+pPL9wl3rc0kqrunEaj21wAlBhCpyXOP2G5yTnML/TLxnw6Nx9mcfr36Rvak
	cNOQQGlBoc8SMzDxUg+089VbqLN+YZ/8J/bn7hpvZskjWNGnedTtIYHXK1vEkih8Xupnc9FisYF
	opl3Alh1tnTteR603Jh13z0Z9Q0XfKIrP6JYnEtdcWjT9qQk7uczwVkXQYK/6tMDXJ5CFGOpw8Y
	TvCXF4o+COAVNXvbZLaR9dP3X0yBIU1k8XsoVehNdltpYbLP7VjlVG9Q8QufyBs2Qe4/RXm8Mx/
	yWZ6BJ3VvryOstcShODJqg==
X-Google-Smtp-Source: AGHT+IEE5Sgq0pD0++96L3Rw5rUNxBxVx36PbQHqHNZ8eGIdUS/xL5nATldx2m3megBQRV1h9xxkCw==
X-Received: by 2002:a05:6512:3b11:b0:549:3be2:bfa3 with SMTP id 2adb3069b0e04-5494c320bfcmr1209187e87.30.1740744838853;
        Fri, 28 Feb 2025 04:13:58 -0800 (PST)
Received: from pc638.lan ([2001:9b1:d5a0:a500:2d8:61ff:fec9:d743])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549443ccfb7sm466768e87.230.2025.02.28.04.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 04:13:58 -0800 (PST)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>
Cc: RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCH v1 1/2] kunit, slub: Add test_kfree_rcu_wq_destroy use case
Date: Fri, 28 Feb 2025 13:13:55 +0100
Message-Id: <20250228121356.336871-1-urezki@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test_kfree_rcu_wq_destroy test to verify a kmem_cache_destroy()
from a workqueue context. The problem is that, before destroying any
cache the kvfree_rcu_barrier() is invoked to guarantee that in-flight
freed objects are flushed.

The _barrier() function queues and flushes its own internal workers
which might conflict with a workqueue type a kmem-cache gets destroyed
from.

One example is when a WQ_MEM_RECLAIM workqueue is flushing !WQ_MEM_RECLAIM
events which leads to a kernel splat. See the check_flush_dependency() in
the workqueue.c file.

If this test does not emits any kernel warning, it is passed.

Reviewed-by: Keith Busch <kbusch@kernel.org>
Co-developed-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 lib/slub_kunit.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/lib/slub_kunit.c b/lib/slub_kunit.c
index f11691315c2f..d47c472b0520 100644
--- a/lib/slub_kunit.c
+++ b/lib/slub_kunit.c
@@ -6,6 +6,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/rcupdate.h>
+#include <linux/delay.h>
 #include "../mm/slab.h"
 
 static struct kunit_resource resource;
@@ -181,6 +182,63 @@ static void test_kfree_rcu(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 0, slab_errors);
 }
 
+struct cache_destroy_work {
+	struct work_struct work;
+	struct kmem_cache *s;
+};
+
+static void cache_destroy_workfn(struct work_struct *w)
+{
+	struct cache_destroy_work *cdw;
+
+	cdw = container_of(w, struct cache_destroy_work, work);
+	kmem_cache_destroy(cdw->s);
+}
+
+#define KMEM_CACHE_DESTROY_NR 10
+
+static void test_kfree_rcu_wq_destroy(struct kunit *test)
+{
+	struct test_kfree_rcu_struct *p;
+	struct cache_destroy_work cdw;
+	struct workqueue_struct *wq;
+	struct kmem_cache *s;
+	unsigned int delay;
+	int i;
+
+	if (IS_BUILTIN(CONFIG_SLUB_KUNIT_TEST))
+		kunit_skip(test, "can't do kfree_rcu() when test is built-in");
+
+	INIT_WORK_ONSTACK(&cdw.work, cache_destroy_workfn);
+	wq = alloc_workqueue("test_kfree_rcu_destroy_wq",
+			WQ_HIGHPRI | WQ_UNBOUND | WQ_MEM_RECLAIM, 0);
+
+	if (!wq)
+		kunit_skip(test, "failed to alloc wq");
+
+	for (i = 0; i < KMEM_CACHE_DESTROY_NR; i++) {
+		s = test_kmem_cache_create("TestSlub_kfree_rcu_wq_destroy",
+				sizeof(struct test_kfree_rcu_struct),
+				SLAB_NO_MERGE);
+
+		if (!s)
+			kunit_skip(test, "failed to create cache");
+
+		delay = get_random_u8();
+		p = kmem_cache_alloc(s, GFP_KERNEL);
+		kfree_rcu(p, rcu);
+
+		cdw.s = s;
+
+		msleep(delay);
+		queue_work(wq, &cdw.work);
+		flush_work(&cdw.work);
+	}
+
+	destroy_workqueue(wq);
+	KUNIT_EXPECT_EQ(test, 0, slab_errors);
+}
+
 static void test_leak_destroy(struct kunit *test)
 {
 	struct kmem_cache *s = test_kmem_cache_create("TestSlub_leak_destroy",
@@ -254,6 +312,7 @@ static struct kunit_case test_cases[] = {
 	KUNIT_CASE(test_clobber_redzone_free),
 	KUNIT_CASE(test_kmalloc_redzone_access),
 	KUNIT_CASE(test_kfree_rcu),
+	KUNIT_CASE(test_kfree_rcu_wq_destroy),
 	KUNIT_CASE(test_leak_destroy),
 	KUNIT_CASE(test_krealloc_redzone_zeroing),
 	{}
-- 
2.39.5

