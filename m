Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90ED1DDE9
	for <rcu@vger.kernel.org>; Thu, 18 Sep 2025 01:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758157747; cv=none; b=VuAQVGwewYuOxBF/rm3ZHiS/9Kiyy0yOEQNY9PeXliHCPRcpLFvp7l4b1V0SKOsH2WwOBqqq0UsyCVllZLqj6P+A8UFrU+bSRr+0rx6d2t+PFPT8lhsxsj2c5u6HTFlFr1+pAcvTZhOHBJUHVATyJ/5VibbNBrLxebOULGi152s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758157747; c=relaxed/simple;
	bh=9P3nK7KV8J73AZhnweqFBC1fyBtgUxeHctZkxwZz33s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WhJORJd6gDnJWURE1l1Qt+NptsiMHsGZfE2d823TAaNEu115EBN1/q4Oh/DfRbfOYgN7ZyfFBrInJIF+qmjhdvV5F7l4LauzBQZxza+4y1Wdrrh5wtwNlwoZ29GDe+CDK/jrJRU1mq3at9KgcoyW1bVmsZmTW38rmJ4J34OdcWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQLsCafi; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQLsCafi"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-32e372c413aso452032a91.0
        for <rcu@vger.kernel.org>; Wed, 17 Sep 2025 18:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758157745; x=1758762545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HHJ7zjhTR9v7nxYizl0r/XT118ERd6F82Pwgt1ZYl/s=;
        b=TQLsCafiYHrSlAVVZm6Zj8Cch6nM2+Xm//vK9suMSe8fIfNaz/QhNxDE3LTr9+NUZq
         OTo3ipo4/OXycfuIicpCtR/5f30jhAoZDVmN/p+X3+3PvF8gTx+UAsemrORcX0t50vAn
         uB1FbkkyZ4BGHazouE+RHYc0bxSdXM4vgi/Zde64gLq4cSw8meTL+3TXY2LuPRtE4KXn
         F3MRSkXAIj2lk12uuyoPwj9UgOebSaT1PNQZTJ6R7Jv+7oQbYotZS0XetOUJ+aqLrlJy
         OcXKh77PM+NKOHr6N5n4d8E1Ivo3AV3W+ga8Hh74dc5qOjjokfLgyz4xfwErFj7le+zb
         MupA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758157745; x=1758762545;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HHJ7zjhTR9v7nxYizl0r/XT118ERd6F82Pwgt1ZYl/s=;
        b=jtVfCLr4veJdiBy/yd4zB/f1Y89R7A8XevuEAUewpsP1mBZikwde/t3bLs1D9quEiI
         RKj5R4vhYWDkA7thOvmhwHofSXeEp6sqdNXBvNgIyWa5ez2bpAQALGg0gVhbdKmlhxR/
         rjG59He52d2sGdWZljsUQy/N0n3mqKBdiW3WJyAWfKnYylQBsxFYT5Nptx12voH8SKz/
         UC3QFmq0MDvbJrsQvk6gyus2iMiURsQE4jTSVnrhx1QQeHIWmJ1sFOdPfbv7/PYQiMuU
         wDm0OG7kzSpVjZ4mGuzhNOs1GlgKPG4izAjFfJrYT3IniHcJrp1rfEjPvmkt8TsKmdcF
         R7Mw==
X-Forwarded-Encrypted: i=1; AJvYcCWAYlwAljYRXQ8zxoCANXmnEuSvPnlBWmBGWsd+SuDkryGrVWV59OJj20QR8VSZomtsAC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWK8K1L9dRfUWkWe1N6AkWR1n9+2kVGQEy/L3D41h0/WVqkecC
	CDNHjPTnzK8GiQmKE0w9iu34lN/PzovS1gPBjqDwSxw53GpMpsU5N/w2
X-Gm-Gg: ASbGncsg76thq6mss1kCG8/lptrmXD59cIoYxThdC2KINl9qQ9kHXD368g3/ZcudcKp
	gtFmbIS7Mdc/icmrQ3eTXGBOZUg9wMeErTPjANqDfum5Dj4MVDedSaHoFYSSJG6gPmQN1l9d7as
	ZhnnKc6yq7Icd9b9lSZPuV3Nkj/0lIr2r5EeXXF3Yex5baeR3M2WvU6TeNvERVihowLMOp4FBvk
	zwm+C61e3OqgCOzaMyjrqVxeMFkYL4JvoVQKvZmUAQEqYtOV2yqwWUshtQt97IRcUS27Dm8Mb3Y
	Ne168xWJSpNuxWPFeEw3qpMx51QzNo/SXOt09II48OeMe+nq0T8WOis1Mzuc/xS1tx5crc+H5CC
	S2XbS6FAAGAo7Ahnm9sV+ZXsxMVEspHtLOy0/NGpiD9ucWMezSl1nlTJOWoZH3WefrMiu2kmfC9
	kTUFQW8EFhsoVj8byQBdYX
X-Google-Smtp-Source: AGHT+IHuTybFeutlNUcFFDtekJviKXLRz++GzvphkgU6pKLG0Unl/lf+rV9kfu1ChnsFkO4xf4Ybow==
X-Received: by 2002:a17:90b:51ca:b0:32e:345c:54fe with SMTP id 98e67ed59e1d1-32ee3f759aamr4709290a91.20.1758157745183;
        Wed, 17 Sep 2025 18:09:05 -0700 (PDT)
Received: from localhost.localdomain (140-211-169-189-openstack.osuosl.org. [140.211.169.189])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ed257bb5asm3550089a91.0.2025.09.17.18.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 18:09:04 -0700 (PDT)
From: Zhouyi Zhou <zhouzhouyi@gmail.com>
To: w@1wt.eu,
	linux@weissschuh.net,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lance@osuosl.org
Cc: Zhouyi Zhou <zhouzhouyi@gmail.com>
Subject: [PATCH] tools/nolibc: make time_t robust if __kernel_old_time_t is missing in host headers
Date: Thu, 18 Sep 2025 01:08:33 +0000
Message-Id: <20250918010833.2760723-1-zhouzhouyi@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 
d5094bcb5bfd ("tools/nolibc: define time_t in terms of __kernel_old_time_t")
made nolibc use the kernel's time type so that `time_t` matches
`timespec::tv_sec` on all ABIs (notably x32).    

Some distributions (e.g. Ubuntu 20.04 on ppc64le with older
exported headers under /usr/include) do not expose
`__kernel_old_time_t`, causing nolibc builds that rely on host
headers to fail (I discovered this when doing RCU torture test in
PPC VM of Open Source Lab of Oregon State University).
        
Keep the new behavior, but add a small compatibility shim:
if `__kernel_old_time_t` is not available, fall back to
 `signed long`

This preserves the intent of d5094bcb5bfd while letting nolibc
build on systems with older exported headers.

Fixes: d5094bcb5bfd ("tools/nolibc: define time_t in terms of __kernel_old_time_t")
Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>    
---
 tools/include/nolibc/std.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/include/nolibc/std.h b/tools/include/nolibc/std.h
index ba950f0e7338..ea225a0b16e9 100644
--- a/tools/include/nolibc/std.h
+++ b/tools/include/nolibc/std.h
@@ -29,6 +29,10 @@ typedef unsigned long       nlink_t;
 typedef   signed long         off_t;
 typedef   signed long     blksize_t;
 typedef   signed long      blkcnt_t;
+#ifndef __kernel_old_time_t
+typedef   signed long        time_t;
+#else
 typedef __kernel_old_time_t  time_t;
+#endif
 
 #endif /* _NOLIBC_STD_H */
-- 
2.25.1

