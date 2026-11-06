Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793975985;
	b=KrLzrXpRDaacbEx8DtDldfEHkKbmV83PxF1OXI9OaIEYQ0ChQjVB2fsBXc6puJanH0qV
	 fIf9ilFcTo+/GWpzvxfoIHRsX83KXRZoZVXXGjgxhH8DLCDdJ61xc8z9GwL5mBdenHyff
	 1xAsg7eMTHFJhiolZ6JkSo9ZJpMzLibS8sqhhAl7krY7K0VH1SS35Mg7nHnhyjEY67oe2
	 /FPShI3ju3b6NaOStvM/KYk/5xit9JYTHWaAjJZp5mDZh7qAULCBsEqdOPyCtFJwtwtVa
	 ASBUK7yl7LMi1P8oDcy2+cvn8+hj+asGz8uV2QJLrvCMY482cKpcXM1bvVZKuzGWEMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793975985;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=UL2zPoMK6Vx7p/yCQJoqQjMHfRUNHZK6rMRN2TLEiXo=;
	b=LoZybcy4Irz/2EOq6jd91UeZv62jLR6Xp1kPd4LDYnPYnVYG+eHTqErTlaQLmW7d5lo2
	 XqST5bgqCVBS+7kIdaXyJqZ5/xaAQsrfP6tTiryuROedu9NHwkftKtkZn0NLxW+OltE37
	 y05plA58Y0GyuAOVuB0v/JkhiRAn+r2xLKd/VyYucGqZQ9GZzL48N73xa/H+FoteTYY5q
	 5a1dW3ktHSx4Xaj1bp9V8/A8lbLB3zx46VUZ4F19gr9pllaJHYxFYB9TLSXN8n30Mnl+k
	 fbnQpFXrdMQAzz2O0SnhyyNR6+1hiavsYRJ2RUO6Nqm7AvahFjyuTF9T/CASgWljDvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uR+3IA4s;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB098606A32D
	for <rcu@vger.kernel.org>; Fri,  6 Nov 2026 14:39:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB098606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uR+3IA4s
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1a2af4c8d00so1583530c88.0
        for <rcu@vger.kernel.org>; Fri, 06 Nov 2026 06:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793975984; x=1794580784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UL2zPoMK6Vx7p/yCQJoqQjMHfRUNHZK6rMRN2TLEiXo=;
        b=uR+3IA4sBGd8EJPiIVr8576SD8mgkJaLtoaNXsCLB835eBK1DjgsI6ZvyuUTPIQtyz
         jev2ZFcbEwdyAkn8kqiEcdA8A1h+eTLEfZjvHLR803TA45bn/d7p2JdKjbbWtk1uQt/c
         TcqvATB8JApuv9N5IKi/1Y1rt/4133CR6pDREBk8PKUK1vTMWwUv4YN9XeBYHPFGmkst
         JxqsYCkwHgfF2/yQKoKpeuLPILl83R7AIt1H4IWVBH+3YNLAop3pqiX6HUmdeI8t1F7D
         XDwQeOL63Mrq7sUGd2kUSLrLfqGll1S66Xn2eQnDVB+Inw9lirccx34XSO05IlKP5Tpv
         bzbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793975984; x=1794580784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UL2zPoMK6Vx7p/yCQJoqQjMHfRUNHZK6rMRN2TLEiXo=;
        b=Swan5Vd8LTjQGzDz707AcsBt4d1NNepD98QeS2NUTJLYR/tRGC/Z7HbDVHF7CZc4+C
         G27J0FilyYUnhl+6FcCWS9FCQ1/gWCEHDhWReZtRLY7ZJNGCi4y+j3p9HoZhxX2gLS7Z
         c5DZrv8ChZiBIExnG9TBuqRBST4AjPwPHpxGWnaHnLkzHhGToZ5HmcjCJbWA7lOt+pka
         SLSVJwobuUs42zCOtFgplXgnzZEBRLeSmTT5wpfaeN5Ky8qHcniAnF6ieTua3A5z6bOG
         fiuli02ee2iYdTTiGBTcNSgOJGX7Gq4i2L4oeMyVQLl8m7l0tkO7x2pFnLX/pOP9m7VN
         gU6g==
X-Forwarded-Encrypted: i=1; AL+hErGmAgucoBjcZZa04m98RjyHIfCT1DqYoILmPsV+pSins4IGfhuSdxaKDeRWBK5GJvRWsDk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+1D0RbH8nIYZB30ioJ7oK0gs0VLw8JGoUvooIC/T5p25C5WsDe
	uowSUvtvatda/fLTuEEcJnj6uCN9Mu96H/zdaLQwvQW/4D8wD5TxD394
X-Gm-Gg: AYBFou0BN+cIIQL0A07D52m+tePdbC4grDPEzbAkBCy9B4w+NFyf9i1YdPe7lJvAdna
	9T8ewrJCT1v4ZgWKItf9lThGekhqa+Ht/A6oJmRxxBBMSLSNn6Ayu5CxliCHLlWbNE3kHoX9Gd6
	3vmcGWgLeieOGNKqs7hzvj0H6syreXaEYwf0l3UUGZbpUwF9nRIQPOVv37AIu4i6G6+1rOKPZe5
	bZHMBnvU9pksHiTNLovlUlKRosomuHsIBB14r+oJGKGAFmHKOfHBC+SxEAsYPE25uK33MsGsHJC
	mMiOd8PYQy2nhTjEeSfdFSL8Rfk3tK+cewyuf8LJtg3XOTwmtBhFbq6Qcj0p7sdLsqVwqm+AT18
	/kbfr6HD47i/kQ0h1VhtERnnsbE/Pe0tbnDd2jnCUqbQMcEssGanJDpNqgGQM2Js85Ls1jh0Nv3
	Xtzk6FvtD3jwM/bVVO1dtV36v5BqG+FACiWq3htO2eALmE+6y3d3P5gCnw75nmtdnddLsmd8H6q
	aEdtzFhi6U/ri6TTXh3jfC7jiwCMl/hQsaetbxrbpv/OMX+D6cvPRg/Ub5ncJL9J/K+9X+MMTYy
	rSRrVyzrzovnXAMfSP/fy9wy5CYqbTOPI/P7DZ8=
X-Received: by 2002:a05:693c:68c3:b0:36d:dd5a:4528 with SMTP id 5a478bee46e88-36f75440686mr4121224eec.7.1793975983721;
        Fri, 06 Nov 2026 06:39:43 -0800 (PST)
Received: from kernel.. ([216.195.201.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36faa6a649csm7182068eec.26.2026.11.06.06.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 06:39:43 -0800 (PST)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: dave@stgolabs.net,
	paulmck@kernel.org,
	josh@joshtriplett.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	boqun@kernel.org,
	urezki@gmail.com
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang@linux.dev,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH 1/5] rcu-tasks: Record callback enqueue stack
Date: Fri,  6 Nov 2026 22:39:09 +0800
Message-ID: <20261106143913.3627722-2-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261106143913.3627722-1-kunwu.chan@gmail.com>
References: <20261106143913.3627722-1-kunwu.chan@gmail.com>
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

Tree RCU records the code path that enqueued a given callback via
kasan_record_aux_stack(), but Tasks RCU does not.  KASAN reports
involving Tasks RCU callbacks therefore lack any hint as to which
code path did the enqueueing.  This commit therefore invokes
kasan_record_aux_stack() in call_rcu_tasks_generic(), covering both
call_rcu_tasks() and call_rcu_tasks_rude().

Suggested-by: Zqiang <qiang.zhang@linux.dev>
Cc: Kunwu Chan <kunwu.chan@gmail.com>
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 kernel/rcu/tasks.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index a20db323612b..fd43cd5d5a48 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -6,6 +6,7 @@
  */
 
 #ifdef CONFIG_TASKS_RCU_GENERIC
+#include <linux/kasan.h>
 #include <linux/mm.h>
 #include <linux/ratelimit.h>
 #include "rcu_segcblist.h"
@@ -366,6 +367,9 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
 	if (WARN_ON_ONCE(!func))
 		return;
 
+	/* Record the caller: the irq_work's stack says nothing about it. */
+	kasan_record_aux_stack(rhp);
+
 	if (debug_rcu_head_queue(rhp)) {
 		if (__ratelimit(&rcu_tasks_dup_rs)) {
 			pr_err("%s(): Duplicate CB for %s, %p->%pS()\n",
-- 
2.43.0

