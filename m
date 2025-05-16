Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F2A230BDB;
	Fri, 16 May 2025 11:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747394436; cv=none; b=lBnwN2930K0s8oNSZO15z1/UVTjyUUcZd+CwHtlmsj7/1z3oF6qekpW8x7My0Rii9puW7uUIhoBT+pEn50Piki1ZxOSiyb4zjEI9kjtt70SK8VWCXI3O2gliH+ozjDx3KGzRRWzitcSLXUInS26MWAnETFpwM1rFN27spTPVOTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747394436; c=relaxed/simple;
	bh=Uy0aeG1AIXqSbmYpuqrAnnoMAdo1u75UgClkqXK6UhY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=edCtmocgqkvrIlqvzTnrQE7/rPMhziQhLvETTyb49dzi6XIhRdQs/NE6h66jhtd/k0XPw3CW7OVClEYEHkY0KXnjEYk5dDAlE2spUzsqqb+Dzs61v8Pfln+rHIYv5C/wvTuWViE+dwZ174fHWBD78qyFfduODugXXo3p98uUcj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aa8tVdhe; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aa8tVdhe"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b26f01c638fso398782a12.1;
        Fri, 16 May 2025 04:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747394434; x=1747999234; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pCSr4VmEAotp64MRj+oFOYJUhSvy36IdBUPUDlxcJgw=;
        b=Aa8tVdhe/MFAF3zOT5g/+gISV+iBt9Sqm+YWgu8CdTbmof2wPuQrOZYcLpK9d2bj7y
         YhX/1GZLdHNCCwgwiEGkrpL3wA9BsKnevAOM66Fmz/kffxKXyEZuhAXn/A9mnHrPp4P0
         5+jJFJZVy5iq7I2HXCTH0HonkNq7/1NYz94F4z0gTUtF30FXtTyATyZjJAQxX3yLqaxm
         eeuNkz16mCIBGXXPoLtsMkO3eOuVt4eh3UpfzYCONks7BjfPtMf6y1suJhb3BIV40uO3
         Y2Iq68hzC0TEtOinWuNdMlVr7WjbtZCWjSYHnb1E6T21n9JjctRi4ABamLMzXtVk2MzU
         VI/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747394434; x=1747999234;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pCSr4VmEAotp64MRj+oFOYJUhSvy36IdBUPUDlxcJgw=;
        b=TdpNgNo0S3ryqu/UhHIydjvZGpbtpGZuGVj4pKUKPAjSCze0GVC1OlrYT6bcCvchMy
         xAnTaBRLGzx2Hh7lkrwX5dhjirP6xFshFzAHGUT0ZIc96dkKuzM7tGHgjPJHXPLaPcV8
         5WPUFcglSBZDNG23fuco1zH6WssBWh3KusHESRCDafhceOtBqlyMP5/VocVUuhDCQwqn
         agw0dIOG+E6AAOeCW8X6FrZa9hyegmDUCveniR8Te2JKUt8fkkH4/4eexH/uO6YynvF9
         UMmV8m+1hY9aI6jb7+jv4AEm72ORi9d/9uMV87SLbi5QuI64DeEk2oh7RdyB/o74F7fQ
         Cp9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVZ23nEgkZNvHEtnTtBz1eAyATrR6Mhl16NS4yZvFjgpdksPQFs3wRxK0Rvw+BN0d1kEZP2ejjOjG5rfFg=@vger.kernel.org, AJvYcCXvSvCPkkLOFpjzyLHnkravjKlfM+ynYkpIt9nfFn91sUGcX6vYpV05oUI9/2yNRMEzAOwr@vger.kernel.org
X-Gm-Message-State: AOJu0YxCB9TvZ8CQUhAlAGF7oDa5BUQSYVHqeCrQvqzH3xZ2OzOo86pk
	tmLPkphlba+wIx7u1acCf9G47WplgUO2J6kaDK9ov79nQAbvu5zPBrFk
X-Gm-Gg: ASbGncthpkNKhSXqUJKZGwuZRr7geS151m3qxLVpZO62vCppegS0+sSOGCphRfcGx8P
	lGyuBVM7IJ3JZAVsWtSGnoj8QbFt2jBTVcba8eyGfBDLRCfop0d2FDiAd00daQry0XwOJ5/Yy7u
	420JhhlXgQT6inEGBBHcRqKah5x5LxT9Af4+TjpoQRxf1Pwq1G1JFKE8+NsvNFgKEUtib3kkLmv
	O/UNACe+Po8HeO5WfsGR9I0S3qqBGz0ypYvFep9Bpc39KN5Hfd9z4VMwE+aQUDkfOQvGmokm/yf
	6L5r3K8K23yv2ViYYWS19sdv4gUAo5zF+z1nVE/iTIwHk/hdoMaabQYW1cI17yUbOHT+SmOFA78
	C9qpnJnnFXTKPsWcD5pI=
X-Google-Smtp-Source: AGHT+IH2JcinnCcrOSfoDWwieWdpeyOrYWAytn7sjz+gY5F1Uhm46lIBgrFw34hUelKk0ZBhtw7l5g==
X-Received: by 2002:a17:903:1a28:b0:231:c05f:29d7 with SMTP id d9443c01a7336-231d43a54f8mr36312425ad.13.1747394434024;
        Fri, 16 May 2025 04:20:34 -0700 (PDT)
Received: from MSCND1355B05.fareast.nevint.com ([117.128.58.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4eb9fb6sm12120785ad.161.2025.05.16.04.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 04:20:33 -0700 (PDT)
From: Zqiang <qiang.zhang1211@gmail.com>
To: paulmck@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joel@joelfernandes.org,
	urezki@gmail.com,
	boqun.feng@gmail.com
Cc: qiang.zhang1211@gmail.com,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	qiang.zhang@linux.dev
Subject: [PATCH] MAINTAINERS: Update Zqiang's email address
Date: Fri, 16 May 2025 19:20:24 +0800
Message-Id: <20250516112024.12035-1-qiang.zhang1211@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>

This patch updates Zqiang's email address to qiang.zhang@linux.dev.

Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8eb7e057b8f9..901a54a633f0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20298,7 +20298,7 @@ M:	Uladzislau Rezki <urezki@gmail.com>
 R:	Steven Rostedt <rostedt@goodmis.org>
 R:	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
 R:	Lai Jiangshan <jiangshanlai@gmail.com>
-R:	Zqiang <qiang.zhang1211@gmail.com>
+R:	Zqiang <qiang.zhang@linux.dev>
 L:	rcu@vger.kernel.org
 S:	Supported
 W:	http://www.rdrop.com/users/paulmck/RCU/
-- 
2.17.1

