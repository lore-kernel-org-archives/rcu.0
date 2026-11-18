Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794991953;
	b=zO3fT+4evhv98tPusLIzfR9Nh7a8tqyLKxJ2h4QZFW1igX6ESiXiFC1z7h2pYDLp9NNh
	 VV25a0VPoM8gfygpy+sE0SdzhnVFLsnBNhrOB6w3ZRtDq7+GsAaHHuKEdGZ9whv2LYvjF
	 Yq5E8nZ5mueB5LH1qWLPaDQy8IVa2Bv3dl8zsCkpgjRAAFZtYR5g1mSax1GxtGd+iSAL9
	 yr2FF+JELyw7AAYrpp3iWqUxIt0alQVPE8c+rYfbUCOGjsodTgnn8oQjzRCeMwkKaXImu
	 lsrWbj0546+gK0zh3DF0/0n65H+ALfZpCBSnqBnnv1uffLkVsdMc3VRwWLIr4eI+emQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794991953;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=9fo6CdS9G/7kEH45TOW7Ki1K8L4FztyBsliBvW4TqJs=;
	b=e2PGwZjUGPwMAUvu5Uijd+13UNejRP3U4hMNUhmMeLTSozQTF9XbH1/WZXgxlbQVBhgy
	 tBkqOYOlj8UHNiHLIha9KO7G6yjZft/F6Rbc2Mm8jR7vaegApQoPK9bWMttbXzPrB8w1N
	 iZIEnNdHR/Xyd6YvBTw2BU7OiZLH2hSDmT51D0FDFdxDUVsWYYOWF3DfVHxW0BZvtk798
	 CzSF2ut6hrp1tUd2GNaRwAXGfs45hMhusvZN2AK1pTFRKfF2ZB7R3fpLZE62Gxc/p7ewt
	 /tDAt6y7gt5RtpBZbtApe0miqukM/d8fZE56G03N8D494bIUmhWTsZ1PVsA+tcrc7zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DkCUoBWJ;
	arc=none smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF1E606A335
	for <rcu@vger.kernel.org>; Wed, 18 Nov 2026 08:52:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AF1E606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DkCUoBWJ
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c5067a2411bso89005566b.2
        for <rcu@vger.kernel.org>; Wed, 18 Nov 2026 00:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794991952; x=1795596752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9fo6CdS9G/7kEH45TOW7Ki1K8L4FztyBsliBvW4TqJs=;
        b=DkCUoBWJt3y/gJ1E7Zpqfi/meuBSFvxhHksXJ7nsEXi1iOcdBWwNel8xIeAnJ3RDmz
         3hjL55OYoCQ5OeIfGUtqi4QGUr1Kfc4UNIhJNykVVa9UrPISZh9VmehDZ9sfJ7LBdbai
         3rus+M6oZ9JYopqwWIWyJUM3svs25cCJ97ewu68RRf+EkEV6bCsFDluZehZBRHjeeNSZ
         HBhptxpOzz4hKNS8GV7A1Rdzl94fKu+b63ThkY1OTQx/Kn6n7wCvYPb1R8C58D8r84RS
         inaZMXpr11wi3dPHefZVKU32jfvedXdfQaTMQJAkcLEpeVPlMeh5GVagbL3HDIXikekP
         0qKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794991952; x=1795596752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9fo6CdS9G/7kEH45TOW7Ki1K8L4FztyBsliBvW4TqJs=;
        b=LfGFd0mGBB7vnEZSGWTLaHIEXC4hrQO17cIasqYtytC94vCFGVHjmk7X0hAXKDhboZ
         fBAxtdgEGxxLHm4KCNDvZ0efOz/6eoNlCKE+lzemJQjrkyidhmjmFuq7ZZWL4zWCARbx
         wUuK7FwZa6XAXdsuNB9QZNzatvWX4alo6mOX9RIkmnwZxvKZGmzhtsxt6adY8RD+CdQI
         +raApoVuZGJPZSU6OOHFgIRuttjPue/UeGyG/nVCKyhB8cH33rfj/EK/v9SnqGs5Cvl3
         nF+gnD27VCpE8ATEyjQH1ASXWZM28+aCebO2pq/nWvtvojAtkghDX1qWZZZ4qEhAX+S3
         Leiw==
X-Forwarded-Encrypted: i=1; AL+hErE97OjlhUIYP8r4nDsIfLu4eIwWpMOE/ZFF3KZl5Zk6ynwT6DWaNBfZa/L8HH53lxI1o9o=@vger.kernel.org
X-Gm-Message-State: APuU4Z+uRc0aCVRUBSaQ5BL3Xbc+XBddOQYXoXKtMz+nq5JTaWTX8p1F
	H5KNcBfzLX88kQ2opJEF7A3NmdgCbkKRVf2QSKfahjLxx8ikMsZmjOhR
X-Gm-Gg: AYBFou3O+VPkdsiyhC4AltOfJ2aQXMWkmRiE1T+M/zp7RU0rphZPnwkunpuKuhNGOxs
	9HXnmlawTXY6FUA5inmxGjUDu/58UyV8NQPShRwV3CIP96jyUf+TPs6YeHLHGBPkYlkiYzqu0qN
	9GAcl2ih+CzJG4D0w2R3DBwno9WtgrbYaCC6L5FYj5FJ7PutAGKWcCGNNmOD3fv44FazvJFrql6
	ru2rXgbdE4RW/MO4cF08XCyrU6FcYlCqecCsmnt1Ihqqvog966Apx9oV1hespglmbjDJddYSa/v
	eC4xmLFJop2hw2tw6ia0aY/aXlelwGxjJ7lT0Rhe/wOfSygYWi3GyLswEH+Rhlen5goL5RdGafU
	qDfB6QDinBExzMh+bgGJZQN0f6lhmqUT4EP+RFkG40KbLxXiApPTvBUAPI2I1CeAP5DM9abyX3H
	+oED5WrdsFqwZryI1dH6tra/2dhXn0TI54Kkp2mFXkcVrmII4b57UgdBRZx76IfdDmiRJxTWmyz
	+kR6bgadQx+L8NrzRU3jVGtt5e+OZCAtkQuh/McVOvBfkWGq3fmvGjTXVEY5ITIV3WAmhjuaWyB
	CLyA+8fR4UIhr80qaLUB/ubnVcKzxqBhbHfO
X-Received: by 2002:a17:907:7f89:b0:c45:d8aa:6ae5 with SMTP id a640c23a62f3a-c510e35d64amr124870266b.42.1794991951443;
        Wed, 18 Nov 2026 00:52:31 -0800 (PST)
Received: from kernel.. ([191.40.25.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c510c83f31csm71077266b.10.2026.11.18.00.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 00:52:31 -0800 (PST)
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
Subject: [PATCH v2 4/7] rcutorture: Test duplicate call_rcu_tasks_trace() callback enqueue
Date: Wed, 18 Nov 2026 16:51:44 +0800
Message-ID: <20261118085147.1668598-5-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118085147.1668598-1-kunwu.chan@gmail.com>
References: <20261118085147.1668598-1-kunwu.chan@gmail.com>
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

Enable the existing duplicate-callback test for tasks-tracing by
setting ->debug_objects.  call_rcu_tasks_trace() is implemented
in terms of call_srcu(), so the detection is provided by
__call_srcu().

Suggested-by: Zqiang <qiang.zhang@linux.dev>
Cc: Kunwu Chan <kunwu.chan@gmail.com>
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 kernel/rcu/rcutorture.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 3dcc3d4318ad1..0e8366eb2efb5 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1315,6 +1315,7 @@ static struct rcu_torture_ops tasks_tracing_ops = {
 	.irq_capable	= 1,
 	.slow_gps	= 1,
 	.nmi_capable	= 1,
+	.debug_objects	= 1,
 	.name		= "tasks-tracing"
 };
 
-- 
2.43.0

