Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65907438494
	for <rcu@vger.kernel.org>; Mon,  7 Sep 2026 07:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788767949; cv=none; b=V8gj1MWDEB22CB+nmWtK0QSgteCqENYAPub/etivnzyEEw+6WtYaqQz4I07p0nPMYcsad1RlRo9/JsXrfz7FI/kvt8pcGcaFxBV+518pQQI9Tk2gymAyYeMioyXZwNsJwJkhVWEyz+Qrt8CyUd+4EQwtw81DChduPocZO6LECuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788767949; c=relaxed/simple;
	bh=khDfC6/LWD0Q4/Opwx8ffd/lQkWbDpCYUNN+ihTrgFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ts67AV/piNCKQzFIG0h2X7NKFl6da/O3j+AnIUU/oztcLE/XnI/y5VtnxWqJg38vHouFyIhie7iUptOv+tVOz9XMQy3VHDqZoyfNz1ZsmjwbpONdT0gsAl6pG//B2ab97XRFnqVW0gLgFYxyDwT7XJPchKPUMQikB9C1aUWhkgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jSpatKAM; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jSpatKAM"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2d032846c95so35597965ad.1
        for <rcu@vger.kernel.org>; Mon, 07 Sep 2026 00:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788767945; x=1789372745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9xsmNs6fEcfIC053Za2znwufqL6cSMJhGirj52zu9CU=;
        b=jSpatKAMZMsJOBsLXeuroRKLvBwPbNOnw8jrl7vBChQGx8BtBmaaq8rgWR6L4bBqt0
         gQFfFFikBZP7SJcLingRaJczSE7NHpLkXvdwgq/omONk78cI5ANL5rTxJeqxD7NuAx/h
         glcOTVrTT/71ksL4c3+eYPhHHjda3Fz8q2IDHg52oX3CHwbekFepL6x65UDqsKcqPq9e
         veUr/+0+1MnUkUaIAFP3yNiIZ+59ac16me0V4Oo0ppHcU4V2/paeGWtVvhgAJCDuYprM
         DafQvYEQ+wV1qqISA+gjDSNAjuGP9f0zr1NBLerp1pA462/lNZznZFghzRVdRC6lHprd
         xgRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788767945; x=1789372745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9xsmNs6fEcfIC053Za2znwufqL6cSMJhGirj52zu9CU=;
        b=foAVAifp4r2y/g/mKzVlBl3lE3F5oJRoqi1I5QfEjPFabZ7tfcsCd9XD8T4bPxsK4U
         ySOcfkOAidG/z7JYV5cZ4k/9dEP0CYzpPzvnsLtZ+FAnJOix6D+1LiyUQ4sZ0DODRWDv
         ncSf5wbZb5JQG/VfDnydAkOc0aJ5bfKjkbe6uFRTXrxgsTrueA9w/9KED6vOQLur6EQc
         1aXTI0tOb9aiHQ9PDdYqxVh+J36QQS7SrUlLkg9WkkIY0XShMDX4pggu/sGcnM0nwgTn
         qZVX5//yFHwTofa4Y9qXrofONXDRQKB3Jql26aO27K8y7bG+jx4joZBVBQyuX3mjkNhh
         cWBg==
X-Forwarded-Encrypted: i=1; AKwUvBy0YspiTOPBgZJ9tEhRtQJbvd0Iikrg2X7fnV5/790KjnRy79sh00vliC0qND8l/0tvt1M=@vger.kernel.org
X-Gm-Message-State: AFuF++ma9o15azYbd1P91ekrdHCr43rhBq2zi7Q5WNWw5quFkr2H5HT5
	+k2l1z//Gbdpi6AS3+JJtLj+J9TcsnmtpOdmQr/R7FCjqO+fxjJAn+B8
X-Gm-Gg: AYBFou37TYjUOetz4TufPKdda6ZEHIpBdAUA/V6gImlDB/oIAuRxXUst/HPqt8gSBHo
	J/uhIwzH6lUbjKLJTUNr2a4Em1swRPIGagtb6QljbpL0EVwr6ijrnCadSVEO4k67qa3eyPrndSB
	sAypshKa8hfgYyoVhiUtdw2oWpCDRtQV7XMxAvsroEFKYWz/yYRnIbJkopEblMFF9xnWv80lotk
	9XVtRYuzMmtvwV/Pa4X0U4THDtbGX0ycGjog+No5KjWEkTA+V2sXxkUt/rC5o9VBy0A3rw44tBd
	Gq5zhYZ4jzsKVR7JNgXVrYbHdK8r5AU94DEvDBUc+0BU8tMP+SQP9+C3R7wfo/svKuEGRAuYsOg
	41022MwWqVrOYKSv22JU05+7zTSkr587GMaCFQH5QsXQuVP0MUVK6Q/XYQoMhrNw0HK73B3DZQ6
	5jO3YcD3qVDzaR2W5B84F/uUIlsoIYCdO50gXNW0Ir5LOpjIODvH0lGOgdvQsRMiGZYHGuPzcga
	j5OlWk=
X-Received: by 2002:a17:903:1850:b0:2d6:e9f3:9305 with SMTP id d9443c01a7336-2db1232c660mr337912645ad.5.1788767944906;
        Mon, 07 Sep 2026 00:59:04 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([185.220.238.35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db14ae7637sm40945595ad.79.2026.09.07.00.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 00:59:04 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
X-Google-Original-From: Kunwu Chan <kunwu.chan@linux.dev>
To: paulmck@kernel.org,
	jiangshanlai@gmail.com,
	josh@joshtriplett.org
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: [PATCH 06/13] srcutree: Make init_srcu_struct_atomic() prevent transition to big
Date: Mon,  7 Sep 2026 15:58:22 +0800
Message-ID: <20260907075829.2073224-7-kunwu.chan@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907075829.2073224-1-kunwu.chan@linux.dev>
References: <20260907075829.2073224-1-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kunwu Chan <kunwu.chan@gmail.com>

The is_atomic parameter of init_srcu_struct_fields() exists so that
atomic SRCU never transitions to big, but neither
init_srcu_struct_atomic() nor its lockdep counterpart
__init_srcu_struct_atomic() sets it.

On systems where srcutree.convert_to_big selects SRCU_SIZING_INIT,
this needlessly allocates a full srcu_node combining tree for any
dynamically initialized atomic srcu_struct, despite atomic SRCU
having neither callbacks nor srcu_barrier() operations.

Pass true from both atomic entry points, adding an is_atomic parameter
to __init_srcu_struct_common().

Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 kernel/rcu/srcutree.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 2af36db37fa9..01f224a56b41 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -305,26 +305,27 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static, bool
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 
 static int
-__init_srcu_struct_common(struct srcu_struct *ssp, const char *name, struct lock_class_key *key)
+__init_srcu_struct_common(struct srcu_struct *ssp, const char *name,
+			  struct lock_class_key *key, bool is_atomic)
 {
 	/* Don't re-initialize a lock while it is held. */
 	debug_check_no_locks_freed((void *)ssp, sizeof(*ssp));
 	lockdep_init_map(&ssp->dep_map, name, key, 0);
-	return init_srcu_struct_fields(ssp, false, false);
+	return init_srcu_struct_fields(ssp, false, is_atomic);
 }
 
 int init_srcu_struct_lockdep(struct srcu_struct *ssp, const char *name,
 			     struct lock_class_key *key)
 {
 	ssp->srcu_reader_flavor = 0;
-	return __init_srcu_struct_common(ssp, name, key);
+	return __init_srcu_struct_common(ssp, name, key, false);
 }
 EXPORT_SYMBOL_GPL(init_srcu_struct_lockdep);
 
 int __init_srcu_struct_fast(struct srcu_struct *ssp, const char *name, struct lock_class_key *key)
 {
 	ssp->srcu_reader_flavor = SRCU_READ_FLAVOR_FAST;
-	return __init_srcu_struct_common(ssp, name, key);
+	return __init_srcu_struct_common(ssp, name, key, false);
 }
 EXPORT_SYMBOL_GPL(__init_srcu_struct_fast);
 
@@ -332,14 +333,14 @@ int __init_srcu_struct_fast_updown(struct srcu_struct *ssp, const char *name,
 				   struct lock_class_key *key)
 {
 	ssp->srcu_reader_flavor = SRCU_READ_FLAVOR_FAST_UPDOWN;
-	return __init_srcu_struct_common(ssp, name, key);
+	return __init_srcu_struct_common(ssp, name, key, false);
 }
 EXPORT_SYMBOL_GPL(__init_srcu_struct_fast_updown);
 
 int __init_srcu_struct_atomic(struct srcu_struct *ssp, const char *name, struct lock_class_key *key)
 {
 	ssp->srcu_reader_flavor = SRCU_READ_FLAVOR_ATOMIC;
-	return __init_srcu_struct_common(ssp, name, key);
+	return __init_srcu_struct_common(ssp, name, key, true);
 }
 EXPORT_SYMBOL_GPL(__init_srcu_struct_atomic);
 
@@ -414,7 +415,7 @@ EXPORT_SYMBOL_GPL(init_srcu_struct_fast_updown);
 int init_srcu_struct_atomic(struct srcu_struct *ssp)
 {
 	ssp->srcu_reader_flavor = SRCU_READ_FLAVOR_ATOMIC;
-	return init_srcu_struct_fields(ssp, false, false);
+	return init_srcu_struct_fields(ssp, false, true);
 }
 EXPORT_SYMBOL_GPL(init_srcu_struct_atomic);
 
-- 
2.43.0

