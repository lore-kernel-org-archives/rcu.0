Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795876074;
	b=aKNphR7iIdlltePw0/nj5KbN7o2VCX64fOGn7EMISRSGT7oI/3zvYW0iJsFcRi24A3z4
	 Lz3JitI03fMRSAQVjEWJ0hduliOQT2PWoFveRq1kNHJZrtQac2A1VuRpMhyQQxo3Mb8nT
	 +SqdGmKhMvSfUqAuNmQ6WVya5Jr709HxMGwyZuFbIbdntQ0AUQ/Ksk2gkKlrmf79vINtu
	 LDTAiCOV6ypA+di2asBpUlzAk8mRcjx6hvi80+oWUf+SktN1eMhwtexVrJa01nf/yL0Uh
	 qdvS0txiONkdjeOkl8as+ZAJLTIg2ff/bWal4Z5S8i6IpCORfAlVD//WkiXDOt/3Yvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795876074;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=MkgKFbzxRvqlDBlKVb19mgxF/hamc+QGmi07NyAUxmk=;
	b=k1BJhrnjQbGpdS6FU6GRZ0cjq6b2doSt045R+VEp3G32kqtz9arRdWFsYRoVBwbc3qCY
	 rm1t3bozzgCy/LpbQb1lTm7/eoKrcv9A8HLpVG+jGCMk1x63maDsxDW9VZHufOjRnepw7
	 wkka9nvbt9OfDBNSuwpOoiWxUHTujATruHGlNHUvUq1WZ89GsHUSQO8J6O7P5CDOH7GzO
	 4+eP+KKlBaAkozfyzptCv7vIMQry//xc+Lxr8Llxv6wuK5mQoNcduvX5rWBVlsUhV7iON
	 NvQtXMJ+7/dl/UdYoQl+pjQeV47yfavY3ndbVibtFuGtjzzpcwN0rYRZkmXn32MuQMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="rCu5y9z/";
	arc=none smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38506606A31C
	for <rcu@vger.kernel.org>; Sat, 28 Nov 2026 14:27:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38506606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rCu5y9z/
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6ae305e3bd9so3949904a12.0
        for <rcu@vger.kernel.org>; Sat, 28 Nov 2026 06:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795876072; x=1796480872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MkgKFbzxRvqlDBlKVb19mgxF/hamc+QGmi07NyAUxmk=;
        b=rCu5y9z/rp7OY3VQW2Z6OFQD5U01/DHLLY4eGc8I09Ek9/D0uchdw84eR5ZRmrPxN7
         gb3QnGZt4dLvOFcrMmqLV1/Uvz2SElZZb8MU2VtkmyRXpkY1xhl+mOlfov3PDi4P75Qr
         4tcfVNusp2PeRAIzY8QUSW8FIb8G146D30PNDRcz/rRVV8wxvg7fNvp7LtyYvIEEnB6d
         qy2MJQoc05an7AeVrrr4UNehmAwieSXhlhnitFsDzzxRYyQuWsQZJDKSP4Xw92IT7DSF
         0P15CAhlG/Ik/z1Lo73Zf216Dyl4bSth/ixWaF7tZuKA5RdYYmUIcprSAkPmwRGjba7P
         BOsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795876072; x=1796480872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MkgKFbzxRvqlDBlKVb19mgxF/hamc+QGmi07NyAUxmk=;
        b=vyDyVlBVprj3aQAK/viwexVu0nz1jmZFxiSNPCR0NWs8rK/RDsO6p9O67yPuduyWs9
         vlMkX8zw8OeAL0C15ceiW+g4nNAZuQbSsIwAGQ8SvTr7ZBrERTGAzcV5nGKmeSI0Zn6T
         Jz30a7iMcSfVm7IAuxkbaftOTwejUOS3I5VKiXQog2iyWHmwBLlNOvWkNa8czxpwAHFX
         qfPxzFMvCwGpvUkZ03jfkAXASi189REyrX7LUc6rWJOII1+lEba3hG5fxsdS/4sbRBOR
         yQ1EmhqD7fPrDRV5o0FD6qeivmCBILkZfvX/xmZ6ZyEna5s7LSzT9kAKmWp2PSZdUJpj
         1pbg==
X-Forwarded-Encrypted: i=1; AL+hErE11ke54uHblBkYrn9Ng+1CtuIAOVSfunn883vAqjbvnszZuFsCwY+fTC0vtizEZR5CNOA=@vger.kernel.org
X-Gm-Message-State: APuU4Z81JImTwaVhDClP3ui4idnuosap6z80zCuS98I7Q5g/g33joSc7
	3HzuejQZEjU/82lPHIyXguoqabaf/+2lwBHEszwYYdzKmjlNZHLqey9p
X-Gm-Gg: AZFdTZdSfPvYGkbhTdUOEvgradZLLpoxdwEQuU5RHZloanghTBlKFuStITeuhAQvT4W
	xLcHXth16a7ZnLhgdW76/TYpq8Jby7awdi+2Cj2XRubLF4OquASo3b0uJFr1UPDzgpaVHdLOED0
	5yTHyjVM1BSc6tN/rOMCMuhDaR4DWRl3L1IaXsMv2hfN04GEsy03mPqdD/Y7Zta+qfJkdiuzKha
	BAWRKtdiXJBN2HEL1B/sm9FP0LqybvQJA1XDmCI6aMzShoa6WeqK0Q+zk3zyac1MFA0RBa9mgXm
	ZeKI5WG9lPBmxji1hD/xiz7WtTz8k1kpZqBUfV7uzzpjoOezZYDm9AfiZrsm9YoqjNu6zH4M2ws
	dZzh2FBSL+MWaDBad8oPE7jXiU5fA4Nn8hxhSei2n79SfuV0u8oMp4MBgxsd+N5ZusNi1TcbmUY
	khzmLftF5wk1sRuVRe61fMBWMHgKxh4Wh0Ee3v8//qRbDHzlkZA0WyqCXo42+JdpUjlTg7oNhMR
	dUPpNwbNJBIDycLf74gKJ1Xhvm9i6ukF/Fln2G3HqtP/QthmMMEODNv3USNeWxeKSkyhYbu9hny
	kaVu1G2pWpjAixV3Onz1MYc169WUF9lcHv7AFtCCHgaeQ14r2bMj8ygNQEJkFSUoYHa4OSG7SdV
	bFEKi1wktwGBpoFs/I0AirWvCUjQXx+Q/gmcXXg==
X-Received: by 2002:aa7:df08:0:b0:6b7:1c:eae6 with SMTP id 4fb4d7f45d1cf-6ba37d63d91mr14903374a12.10.1795876072181;
        Sat, 28 Nov 2026 06:27:52 -0800 (PST)
Received: from kernel.. ([191.40.25.3])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba36e35ca6sm12448436a12.4.2026.11.28.06.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 06:27:51 -0800 (PST)
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
Subject: [PATCH v3 2/7] rcutorture: Require debug_objects flag for debug-objects test
Date: Sat, 28 Nov 2026 22:27:24 +0800
Message-ID: <20261128142729.3756679-3-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261128142729.3756679-1-kunwu.chan@gmail.com>
References: <20261128142729.3756679-1-kunwu.chan@gmail.com>
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

rcu_test_debug_objects() checks for missing callback and barrier
operations only when ->debug_objects is set.  With the flag clear,
execution falls through to the test even if those operations are
missing.

With CONFIG_DEBUG_OBJECTS_RCU_HEAD=y and rcutorture.object_debug=1,
the trivial flavor can therefore call a NULL function pointer.

Skip the test for flavors that do not set ->debug_objects.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 kernel/rcu/rcutorture.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 67fc770abc102..1648e6369d809 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -4774,8 +4774,13 @@ static void rcu_test_debug_objects(void)
 		return;
 	}
 
-	if (WARN_ON_ONCE(cur_ops->debug_objects &&
-			(!cur_ops->call || !cur_ops->cb_barrier)))
+	if (!cur_ops->debug_objects) {
+		pr_alert("%s: %s does not support debug-object testing\n",
+			 KBUILD_MODNAME, cur_ops->name);
+		return;
+	}
+
+	if (WARN_ON_ONCE(!cur_ops->call || !cur_ops->cb_barrier))
 		return;
 
 	struct rcu_head *rhp = kmalloc_obj(*rhp);
-- 
2.43.0

