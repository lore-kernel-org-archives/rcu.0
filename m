Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793811570;
	b=XkTZj+B/w9LLEr5gJIkY364lc0VJ23baTj15LG1DGSM+HvxCpDTCD4KjFjSXImBSUVEa
	 pOcd9EaXMu9BWv2CSIqmyjKFudhaQeOGDI0ms4wNjwBrtMBMmlBpeFY0AiOP0jrfzZYOy
	 tX64k5zARp6OLEyHkKJOF+0F7OFxQEuXYBNfzehuJ1+GY63OMlGlYock69NpVLLrGgQEQ
	 Nvr5H+slnWwgMXw6rwAhIlxTdFD5g2D7fplZzyO6WzWYiU7I9IHWdCX9MxiMfwyNolyAe
	 JBpJ3u5lzHH1ggBfUvIBTVvoae524mxfVsVo6+S9IvGooHg0e5TZwMS+YsXauUruTtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793811570;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=h2kyCpxYn7quzffs+glqhT99zkVyPPhwyZ9QmptjaK0=;
	b=dtGh+UTC/NDMPWVzEkg8GyZkRyFB0CJUZLe/pxY/f7Yr1/OmA7oNnUV5vNAkHIFnC5Bt
	 OMDFqsG8NrBhDny9Ua8YW0/cLjvB/u0w2pJtEYu8B5lnF38zEVJs29ml/ek5/yyJYr7UR
	 Z+2dJr/iq4p6WFGe9uotaBbPJZ9W75hCBas72NVsJLQkLQjdPyxTbUu8oSqES3civeahW
	 oG1/F+8OFVd1AI8pz5RPnnPrd34U5IoNUEburCTTzKYALGx/Sh05GV5D3gNu3UdtAxX0I
	 8n2ySpokrt4WuMv37fpT9D/ciidPwIta2UU4lf5aDCUtgqspDRx+Afa+5rIRzRjOD6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZdVTN83c;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB66A606D817
	for <rcu@vger.kernel.org>; Wed,  4 Nov 2026 16:59:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB66A606D817
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZdVTN83c
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-35c76e9614aso1211489eec.0
        for <rcu@vger.kernel.org>; Wed, 04 Nov 2026 08:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793811569; x=1794416369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h2kyCpxYn7quzffs+glqhT99zkVyPPhwyZ9QmptjaK0=;
        b=ZdVTN83cZuFdJy3X+OheFWasrMSC6JUzg+o9axzkpEXkzy3ZcJgs+O7DUe4iW541rM
         8Qa2TjnoF/4+YdE0R4punsPO6vNtDfrsofSpoxTEi7f5bCWNJPqqWSvkmuXPdrUHiJBF
         zHJpQH0jKZN96FKPNP9q6mQpAjU5e0ltO8u+rTtLxq2Z2hd5g1rQMrg3MJFl9Jy9mcK3
         NE8JAvD7FJP/h9XT4k2XM+PHLse6YhNUNfTfxUbkt2g1ne0TSB51Z19KCLpaedla1UdG
         9rCjI5d6khFh/7SQHcVjcXGACkqIWV49AFM6/oYgeoFc2FAZ8l2/2021b2Ogs6DcC6V5
         GaDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793811569; x=1794416369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=h2kyCpxYn7quzffs+glqhT99zkVyPPhwyZ9QmptjaK0=;
        b=x9uJZyEntYzcfGC1cDa/VqRS62AKWuOtyEPIWO1rqxD3RgGPBrXvzQNhZs8oBVwmMf
         egT/CsrjBtiIDtFAtJ9y7IEKYu32PeHRRjXX7CZLBRBNC9LQBzQhlPiBOI25NWdviKrv
         nJgcps+kqIN1YjwwsSP+ZBXWY8EA5rYp2EU15dc0EZt4gsuk/eFar95zkCr0P+vBMY7r
         jEmX2eZYvNXKFN6ITK/B6PAkeqj+xwmqb1uf+5hHmR8H6LEdJg6u8Iqq7K20MBMsJeEZ
         HF8inLQMp8Dr2u54zbkCwQYheT6h+WkwnlfSTBcw/3xBIvoygeFxLOc1kO2Dx0lAyAga
         fwyQ==
X-Forwarded-Encrypted: i=1; AKwUvBwR+d0L/Kl5AyZXSY103ccI6XS81avnVMH5sBQQ3UWIsTusBvSUsMgZu07tjk0hjqXN1ak=@vger.kernel.org
X-Gm-Message-State: APuU4Z+oa1ZgYycZpLCJcIC1BKwzhJDKXo4ZnRTcyDEj+5UHtWyW8Bq2
	ZdbpY0s/j8rCo3lV4WzDqXueZDu5xA0qVLavjEO0jTaMefGGarnoUdBI
X-Gm-Gg: AYBFou0Et/RS4QlNsqo0xdBcmYOipy6nslscA9rwwi0MFDckRQELHoT6YdXEhau1QQM
	DjahgDFPtB3+rt+gIWQkueW2/RCZOFZacvkJFK1pwXe2eHOfceHw4JTNc1sNTgYd/CloHQaI6e5
	br4Mk5of1HjaFXCXC3ODm2sPSgIU4JV5rx+ZiboE2b5pcmu7WYoiJ6h1FvdceRUP13aZVF0K/iX
	CYFGQIizAH12Afi2OJP4CEYDYl6BOLQ2sf07oOxrwXppwaXZ0QbTTdJ9rcRnsQLmo/R2+9p7YpZ
	pqSgR4lMVsathG0adyOHxRa9Nlt95LMQNgm+lXwPws6ZgpSpO50T11NnvY4Q0+4L2UryU0wr7HI
	2ph5w3M1nVgsjC34ebLELvD9qJO/Wkog5Vzr0kkXMF6QqKcN1Oko3VlufMuw0hlEvwhIkRqmQ41
	1YiNaFcRHKAiF2bdd0I+yfbptD313LFFklbXiSNihg3XBnM+HH+XWhLuF+uNWIQPR9ydXJoxD2B
	fwuGJQG1nGRKjDKz7ZSi6M8omXHkpwPHj926NbUellvIxU9nNkCReNPrxfVx4C04qMh9WQYEGbh
	nBiOzMeQTvpXLKz83wgTk2hEeDd3h7J07Lb45ZE=
X-Received: by 2002:a05:7301:1a15:b0:369:a113:756f with SMTP id 5a478bee46e88-36a423f980emr22997970eec.34.1793811568303;
        Wed, 04 Nov 2026 08:59:28 -0800 (PST)
Received: from kernel.. ([216.195.201.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38d46fcsm9019567eec.13.2026.11.04.08.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 08:59:27 -0800 (PST)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: paulmck@kernel.org,
	boqun@kernel.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	corbet@lwn.net,
	mingo@redhat.com,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	josh@joshtriplett.org,
	urezki@gmail.com,
	dave@stgolabs.net
Cc: stern@rowland.harvard.edu,
	parri.andrea@gmail.com,
	will@kernel.org,
	dhowells@redhat.com,
	j.alglave@ucl.ac.uk,
	luc.maranget@inria.fr,
	akiyks@gmail.com,
	dlustig@nvidia.com,
	joelagnelf@nvidia.com,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	longman@redhat.com,
	rostedt@goodmis.org,
	qiang.zhang@linux.dev,
	kunwu.chan@gmail.com,
	brads@mainlining.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	lkmm@lists.linux.dev,
	linux-doc@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 27/28] hazptr: Add Bloom false-positive exact-match fallback
Date: Thu,  5 Nov 2026 00:54:45 +0800
Message-ID: <20261104165504.2430480-28-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104165504.2430480-1-kunwu.chan@gmail.com>
References: <20261104165504.2430480-1-kunwu.chan@gmail.com>
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

After 200+ scan cycles without progress, do an exact-match
per-address walk to determine whether the address is truly
present in any per-CPU or overflow-list slot.  If absent,
complete the waiter immediately.  A wildcard counts as present.

Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 kernel/hazptr.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/hazptr.c b/kernel/hazptr.c
index 66954251c332..13ae9eb26a8b 100644
--- a/kernel/hazptr.c
+++ b/kernel/hazptr.c
@@ -407,6 +407,7 @@ struct hazptr_waiter {
 #endif
 #ifdef CONFIG_HAZPTR_DRAIN_ASSIST
 	unsigned int drain_cycles;
+	unsigned int bloom_cycles;	/* cycles since last exact match */
 #endif
 };
 
@@ -852,6 +853,18 @@ static void hazptr_scan_do_cycle(void)
 
 	mutex_unlock(&hazptr_phase_lock);
 
+	/* Bloom-false-positive fallback */
+	list_for_each_entry_safe(w, n, &hazptr_scan.scanning, node) {
+		w->bloom_cycles++;
+		if (w->bloom_cycles > 200) {
+			if (!hazptr_scan_walk(w->addr, NULL, NULL)) {
+				list_move(&w->node, &done);
+			} else {
+				w->bloom_cycles = 0;
+			}
+		}
+	}
+
 	list_for_each_entry_safe(w, n, &done, node) {
 		list_del_init(&w->node);
 		complete(&w->done);
-- 
2.43.0

