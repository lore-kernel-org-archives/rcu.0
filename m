Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793975996;
	b=x43baVpkUYWx2qkFgWwhNDjUYRwQnrbIRt6fcFts/W6jb6mmcxOkD8OhMWISDGuAX3Hz
	 vltH1X2AsJ9BzYdNanNzt5HMNw8mrER0KVRMfB+9wUzutscEPyi8QCTv3NNuVrVnGrLHL
	 NIcxaKBDX5T2Hy4rgMjtIV40YFh1ffso//UdXOWGk45yw5f4QPT+NaX8EUqVnZ/l4iKin
	 N99RAKyveKhDTkkpdHQlF6xMO9hpr6QB7IM3Tc2jtWXqY5udqqr1TEEW2dv+SDjA9LXqV
	 dgYOngndQZ25qOI9VUrSTBUEHmJB3M/xQ9F8UwVG+SqsjzedGiSUS/0Y09TYp7T9YNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793975996;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=G4kP5SUxSDXPf0VaBA3CGEW1gurDI8/8IILo+sIVkNc=;
	b=E4jlkMTL8Doysl8fXxTJ0qE9Vi2Ih/B3l696irLa5aBiBCkUipCo6tgi/9jpKOk3raZ8
	 7Sx9dIKAXSFIClypsVvyhtav1bqKPU4VWNUtg216nCl2apLrV4zoGUgmipjkbpZxNmhFN
	 5k6rC36VV1GijjkeCJtZHjPktbpo3pSGdg+7xlvWnwbx6eNtKE3hgBvlpHU5CnOJNVNEK
	 LQYxG9dplhn/S4bG6NBOExbOV9gm1BadQ5Rhnd3xtczhk9RiABW6n/qX7UJ9sbAOE7CLS
	 ZDGjMHVyA+YRvK4xJoj8/uUXDQkwFXaICh+wK0Jn9pY8MQShKls+t536FeF1P31UicQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JOknn993;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB31A606A332
	for <rcu@vger.kernel.org>; Fri,  6 Nov 2026 14:39:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB31A606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JOknn993
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-36f8cdd30beso754392eec.1
        for <rcu@vger.kernel.org>; Fri, 06 Nov 2026 06:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793975995; x=1794580795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G4kP5SUxSDXPf0VaBA3CGEW1gurDI8/8IILo+sIVkNc=;
        b=JOknn993yVnz8eAgpZZBu6G1zaQNsUIIv467fXSUI+G9Od31BojkWLkimJTrqy6St7
         B2ALZxck3LyBfdvODkcNDwqVFfqBY9pnCt0gu3ebgrkYKFqwNIcxNe/8kTvIjmEHxlS6
         7EM0OdkM7MxkNSJyoTvVwfEzkqSJMnUk+UNshwLMdZXbR229GA3eseNY2K23vNeDm7EL
         VFwx07hKI6+SY+Bxwk5iYT962/eJ8Fr56UAKnwQbczrBhtxstWF19b6O/m4tyWkDlSlr
         9SffVFbUuslHMS6qVr7jBPyUb9gTk6m5Q+3nqFd8fOYnFASkaMd978l/HEemqjGPfmmp
         Cwcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793975995; x=1794580795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=G4kP5SUxSDXPf0VaBA3CGEW1gurDI8/8IILo+sIVkNc=;
        b=FV7urrhNyqF3fym7eD+5tGxhAKyVxTAEd93i/QobxzDcF/vTw915EtsSwYZu1uRPaF
         DbsfNifVEC0Juizu7oxGOrkSP0K1pylv2+hD0B+r83Ee8G/sEzHx0y32S6HEve1g9W5C
         771kj0DVsGDMCL748bT6sCuGqGQRik6KHE388s5GeCezAC2quIQyUlaqNKp7mzEtXfGr
         UZFSg89cVZV2nI9lBwB8jqXqidonEasHz0W8mAM+uYikakeBf4Qn64bCeHrAXMYKtHr7
         5SUI6m0BrTqDcd5wgIvma0MPkftQZSq86q2U+kVQoBi2eagflkhei067OFWtsEe/FYWW
         AHHA==
X-Forwarded-Encrypted: i=1; AL+hErFFIHLUZS341H2iwh6/sO9Q8f8x6egn1NnOgwPULKPxLniDbMGY3EhRyzWyBWj+EZ3uFMo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/6iq1pM70xe0QqHxWQDKcdWcxls31FBbLrQECpbfz9+M/r1Wr/
	m/O9zOvUE0nCzmaatrF4WGMFKPP6QM5cNPwMhVCMtGAKoe7weX9F0Hdc
X-Gm-Gg: AYBFou0M72VDi4ZSD30gzdDNAocft9VwP97AO7do6aCZiKY//fkDC3wkOWXh+gi3gMD
	znFGQllKnzAWZMskAPEkXGk03okAk7aQbdhZrIA5UvRWy4MK+BggyyVIlkMsBctcZTrqRZ5bFHm
	fnI35pP57Od8PwlhLr+qMOlS9BFUdgaqtT9o4PVxIf7V5lvl3fLaX2VHqgpfInfDrVd6j5IFgCV
	1BkWzKE+mhlctDbksegeGzXzKklOIEwRjsviGRxzh2xOdQLPRUiE8fNOjN3FUNT28u5L+rUW6jK
	NSbq308ZZrpFJ7m/BoTML+V1ih8A4IG8evu9JBggwC19RAzgmsjvGGPV34ZC626xS5WFuWbNyFK
	9U5OEJHLx/BHvTsqu70dwOE/RX+zKcuUA/5TT6ofSI5zB3toa5XuWW54awTRfnqhDmXfvfGp5CN
	Z3WczgmjBSwTLuGKXS6Ngz3G6mWv8yA9dfrEG7cubD9rDABLGC3S6lPPK2le7v7yalCsArvASTC
	SQySsOn0Jf9vhBf6g7tsl6UPJkMS5D87CTy4nge4hjqP4rV627YbkNFDJaMsqiVS3TUHFiJ6X4M
	Hx+7vbEndEyvSSab+rNTlhe3jSg4LDYQerygGgc=
X-Received: by 2002:a05:693c:6096:b0:36a:1d6a:596b with SMTP id 5a478bee46e88-36f77200d2dmr4440985eec.29.1793975994651;
        Fri, 06 Nov 2026 06:39:54 -0800 (PST)
Received: from kernel.. ([216.195.201.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36faa6a649csm7182068eec.26.2026.11.06.06.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 06:39:54 -0800 (PST)
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
Subject: [PATCH 3/5] rcutorture: Test duplicate call_rcu_tasks_trace() callback enqueue
Date: Fri,  6 Nov 2026 22:39:11 +0800
Message-ID: <20261106143913.3627722-4-kunwu.chan@gmail.com>
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

The rcu_test_debug_objects() function tests duplicate-callback
detection, but only for torture types whose ->debug_objects field
is set.  This commit therefore sets ->debug_objects for the
"tasks-tracing" torture type so that duplicate call_rcu_tasks_trace()
invocations are detected.  The detection itself is provided by
__call_srcu() because call_rcu_tasks_trace() is implemented
in terms of call_srcu().

Suggested-by: Zqiang <qiang.zhang@linux.dev>
Cc: Kunwu Chan <kunwu.chan@gmail.com>
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 kernel/rcu/rcutorture.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index a056a79aa3d2..5ee9e70a6199 100644
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

