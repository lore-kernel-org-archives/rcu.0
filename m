Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C47B3D953E
	for <rcu@vger.kernel.org>; Thu, 10 Sep 2026 10:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789035088; cv=none; b=IWXmSu2EulEo6/uNs9e7MA7atzmf0tEmN6EHUfRMSCLl5yPvILH9XqXuDXNFfe4B6Fk5frqahVK/RC8GUlK9r/cxycQiaas11j2XRhs7llIvEDCntVBKr4NQmpK2olfUIyGSFayeWizRN7Uvk+xihMm7c6DrrgMtKOcn7+/Z7Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789035088; c=relaxed/simple;
	bh=I0hyD6QpnF7dhZ5CklyKlcMRFnfbUR0Huh6rVBxwZgA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rycNR5rjUot5dyzfk8qk0LeV40g4mGlYpOFxNJ2qc8Nmo4GfIM47aqO5sAYxL5Wjfo30aV1QoNtgzqXnn/liznfRk1dn6uhheBphhHSYQLh5eeEUhWE6SheZ4UaobDjWUr4o++NVZwS/jYVFZMkuIu23GjbARNZvmJWifTPXGzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dAr5fclo; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAr5fclo"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccafb750so2000751a91.1
        for <rcu@vger.kernel.org>; Thu, 10 Sep 2026 03:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789035079; x=1789639879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LOI+fb+5x5F9yCJx1orzgkASYHto5WjfhROpPhJVUF4=;
        b=dAr5fcloy6j65qHPpqZP7N7Nloaue4HKn8r7hI3R9bVHpk8jJuQGcWvcx4BMxmKqZ9
         jn484cz/Hc5Fkf9dap7aiAk3gV5FOSAHI2IxWIXGc+VGAnxNAKX9a216Wc3vmTlbFyL2
         W7JjmnmkS5BliY8bxnXxsZbaS2mwi0p+68IoRl/XvSE4KlO98ouqg09YLaokOh+O3Xyw
         2Rn0sfGF40bTR/TFLH1pm9nwDJL8/S9TbWDb3TQPpAO4+snSynz5bLAJ8pXm4/u+Z8ns
         Bv62CD+4eBIzjPYdHc0BmFnJx1vdTTCqNYT63EvQv8ZHD4xV3gcuaXziLlSiMmkStjiK
         H5Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789035079; x=1789639879;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LOI+fb+5x5F9yCJx1orzgkASYHto5WjfhROpPhJVUF4=;
        b=bXRCp0yXXwrbbiZYXYY+tQq8xzM0zZO9hFLhM6Kk7Lbq3sCwjGdPQEFXWAVlvit8ql
         xx5I7LdnXMJwt7Hv+uOA5IXvriXuyG/yLhwiAI57qO3rQVWUEHDedkIZTTBIpOW1Zals
         ly3MDpxja+UnAu/txkOu4CYKsIjHSeMsxFQk0+xExELUyCCAiEO5iZ+g9LUKZjJRSNyk
         rBBQqaJnAZTl6dslK4gBZUcERQFd2Sl5EQyWiP4D4k9j3Bs+msUoW/5jfxiFdtrM0lOx
         Ly5OP1i7bp2s2fw+rOyr+RbKdE+Ouzs/9R1nF1dDFZmqgyv0ucTFkwtaWWxNEGKucpXC
         5K5Q==
X-Forwarded-Encrypted: i=1; AKwUvByHHhYlK11yNVmYQ7PnxnLIWBg+xeIqYj5W+tlwbJ4fJbDhA+K16GczD/OzLCQUlW2HV+0=@vger.kernel.org
X-Gm-Message-State: AFuF++n0ExoUZrK0nHQeFOsUjJZ2ATjhwEbkkV9hGkde9MfuBH8x1JIL
	q3smCMw7q5P0mOUVy7VUV0sKSZIcdAxxSHNBjMgqrfmMubrzA2tIbEUJ
X-Gm-Gg: AYBFou1aFDK0pgLwx+0pw7uiDjWD5AMoYvNfHYVcbCpeWbGXtrch2oGQeJ1IvXz1/8a
	tZwaf2d+Xrh+sY144Axxa6OpNMLqSIDGYpNMO8gRIfHppetLIocxWRr8DDKB8tqeX0A3qbxmZst
	hr06VRWhftu96XvM0aOqcovhavHJdDQVzkpeJeYRW2r5Px1TM4jgGs1kSVbr6ve24uYZeHATYWZ
	NRyCvK1qzozseZ+MLqiVr3picjOdxY5BAo7CfBTSA57BcNO+Oe9yxjxjhxJNjHVunRuMOSvVBKY
	GdtOlfZml6PgSLNiNveCnS/ylONZugMILkaKtnBERscbuELCj+GuRu6NZ/DUlcVM/iOOLuT6b6j
	UuTKQoGxfDZwpg6l4UjzXLXh6wzCoEnlUA9QYGwmtCZaVkmzN5JBzkOcTLcmGMHFw1HjRZMlOE5
	7gYFUlbiGxJr4CrWt9w+X8Lv50vTdVyAci4UIZvSpn8Kc/1R84K9h8VYMC6GzxslM10Z1Q2a1nl
	mcewdRhr9/WtIHVHZjW5/2yRnwT1A/qIEBbu0AyQhaOpjn7OApmGjjQpKjbuVGLxFFTt8P6JF3Z
	7gQCzo0K9SMUiS3RCusX7LFQs3uCNXL39CdBTU3Vwb2sF14mj/avHdoyC2Mmyho=
X-Received: by 2002:a17:90b:1d45:b0:38f:2168:b9cb with SMTP id 98e67ed59e1d1-39bac1d89b4mr16724648a91.9.1789035079142;
        Thu, 10 Sep 2026 03:11:19 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.252.203.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d7e8acf98sm4232116a91.15.2026.09.10.03.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 03:11:18 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: paulmck@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	josh@joshtriplett.org,
	boqun@kernel.org,
	urezki@gmail.com
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang@linux.dev,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	harry@kernel.org,
	surenb@google.com,
	vbabka@kernel.org,
	rcu@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] rcu: drain kfree_rcu sheaves from the userspace barrier hook
Date: Thu, 10 Sep 2026 18:11:11 +0800
Message-ID: <20260910101112.1648978-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rcutree.do_rcu_barrier test hook currently waits for ordinary RCU
callbacks, but it can return while kfree_rcu() still retains an object in a
partial per-CPU sheaf.  This defeats the hook's purpose of preventing deferred
frees from one test spilling into the next.

The patch drains kfree_rcu sheaves and batches before retaining the hook's
explicit ordinary rcu_barrier().  Four counterbalanced fresh-VM pairs with the
full validation fixture reported 60 -> 60 active objects on the unpatched
kernel and 60 -> 59 on the patched kernel.  An ordinary-callback regression
test passed on both kernels.

The primary reproducer below removes that separate regression machinery.  One
fresh control/treatment pair with this exact 41-line source reproduced the
same 60 -> 60 versus 60 -> 59 split; both cells reached TEST SUCCESS with no
problem-class kernel records.

Save the source as rcu_barrier_sheaf_repro.c and create a Makefile containing:

  obj-m := rcu_barrier_sheaf_repro.o

Build it with:

  make -C /lib/modules/$(uname -r)/build M="$PWD" modules

Then, as root on a disposable test kernel:

  insmod rcu_barrier_sheaf_repro.ko
  awk '$1 == "rcu_barrier_sheaf_repro" { print $2 }' /proc/slabinfo
  cat /sys/kernel/slab/rcu_barrier_sheaf_repro/sheaf_capacity
  echo 1 > /sys/module/rcutree/parameters/do_rcu_barrier
  awk '$1 == "rcu_barrier_sheaf_repro" { print $2 }' /proc/slabinfo
  rmmod rcu_barrier_sheaf_repro

The first and second slabinfo readings are 60 and 60 without the patch, and
60 and 59 with it.  kmem_cache_destroy() performs per-cache deferred-free
cleanup when the module is removed, after the measurement.

// SPDX-License-Identifier: GPL-2.0
#include <linux/init.h>
#include <linux/module.h>
#include <linux/rcupdate.h>
#include <linux/slab.h>

struct repro_object {
	struct rcu_head rcu;
	unsigned long payload;
};

static struct kmem_cache *repro_cache;

static int __init rcu_barrier_sheaf_repro_init(void)
{
	struct repro_object *object;

	repro_cache = kmem_cache_create("rcu_barrier_sheaf_repro",
					sizeof(*object), 0, SLAB_NO_MERGE, NULL);
	if (!repro_cache)
		return -ENOMEM;

	object = kmem_cache_alloc(repro_cache, GFP_KERNEL);
	if (!object) {
		kmem_cache_destroy(repro_cache);
		return -ENOMEM;
	}

	kfree_rcu(object, rcu);
	return 0;
}

static void __exit rcu_barrier_sheaf_repro_exit(void)
{
	kmem_cache_destroy(repro_cache);
}

module_init(rcu_barrier_sheaf_repro_init);
module_exit(rcu_barrier_sheaf_repro_exit);
MODULE_LICENSE("GPL");
MODULE_DESCRIPTION("Reproduce incomplete rcutree.do_rcu_barrier drains");

Matthias Goergens (1):
  rcu: drain kfree_rcu sheaves from the userspace barrier hook

 .../admin-guide/kernel-parameters.txt         |  7 ++---
 kernel/rcu/tree.c                             | 27 ++++++++++++-------
 2 files changed, 21 insertions(+), 13 deletions(-)


base-commit: 50d05c7c76c96b90462f24debacca971d2e86713
-- 
2.55.0
