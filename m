Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B9A1E47BA;
	Tue, 19 Aug 2025 01:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755566788; cv=none; b=p/XlRh7cQEOP5/gAjr7yU45n+tH5d9oWl5mkLimY0Y5RFPn34pY61SL2f6NJGa3x3rZuzYnnhBtAbsZes8ue8GXZW6ydU5P/K3Ow0QWeiubeiK6hMRWnIZUsv/eN/IyemKONZQa/QOl18wC3FGQs1SqV/DPBhG0qsBIh1fgUjrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755566788; c=relaxed/simple;
	bh=agYR481QyjyS/7Enp2FSpAI7AE9rLtWb/AeMmfEvraM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fh/BenRUDE/GyBqjxv01/G9sbHKkUxwiAfpENLh+kGbTCwy6fpnwFBJI+aLqukGBZ71emWcyBeDNA8fcwnyvr4yeQksH415oiJKXAI5SGSTkhlQzX+FUKnSF06zrWSanhamJJ7XZbmtb9l3U6DGiGxNsHGSFMChxUEYxQwjgXyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hb1YSJUR; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hb1YSJUR"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76e2eb9ae80so3645598b3a.3;
        Mon, 18 Aug 2025 18:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755566785; x=1756171585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pmmqb+0QJFMvstqyZRbkCupg6wif2qsh214IwZwNpHg=;
        b=hb1YSJURPDVksdcMEMJWSXuQfRDCl1xcLwTR3cHRO0Znz7cRxgwJSINjFLLEM5q2zW
         rqluew5G75O8erBAqii89N1hFcLda+PQFRpRSrzGQDPLYmz6d9wpRRrbMyXH/TlWE779
         8C7Vjmhr+VK/FVnRtLZYy4lZeaxnYcPwd9IRzw7pzhtL7dL9LliHK7yS8fvFlihtMOpy
         HCvu6+4bgjSnQYlAu60EweJ+vx6HVmh/0JWRH40LRgPpv6bFShKkhN2hbsyxK5IDSjX6
         ul6G59lAgFagfYJigqdSnmE0VJgESF0hDdpas6e29v8UCcn/tCYTBcE4OQ3H34flljbB
         JAtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755566785; x=1756171585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pmmqb+0QJFMvstqyZRbkCupg6wif2qsh214IwZwNpHg=;
        b=HeJcdUVFTKZgQyhsFUfckPFuVen0FjYYh8TVM86rvJujYQFz3IhKjuQJUdy+q6UjYV
         YtHAPEFpTlAF+m24UBxYGbobr8fxnNLw+9O0gDQ8Zw0m48AE/iEVpcUQSqinsKxmMynn
         INrv7SVvsrfWZnh5VhGiqVPhydYUZouJz6IO0Ljox4P9PsGueYw0dbAbq/YJaxWqeWJ6
         nrIVWvrGUUydLeaxIiyTCRkSYQzD9e/aDwHIhyTYI6nO+Oy1PdfOnxt9OQH0cR7QGFbF
         0CVgMGtfhj/b+zubNuz0sOVz2D5sKYPNefhRjHJEDB20DWjIkRdpZEkiVY5zJ8GV3A/w
         rGWw==
X-Forwarded-Encrypted: i=1; AJvYcCUhzqQQ+f1S77Q9U3CW/y2BD6CCmKo+D3Vv7V/piT9iKgYRE6xXWLD6mqcPvOvZbQf1kEjg@vger.kernel.org, AJvYcCXrd+Y0kqJMPQRnkmabtK/rzW0Nhq2f++sIxtGgXJkZMG93nB8QBZf+flUEa3EqA8NX1JUYhUfiegE=@vger.kernel.org
X-Gm-Message-State: AOJu0YziSAkOOyICH6pde8d87snXKyAdF/bkPvfnAVfupK/d/GP6q8my
	uA/QOthEibJHadh1J45q/uD2Hi0QlX3c1D7sKqDHCJneE+jjhGh2dCGX
X-Gm-Gg: ASbGnctiYuRKWor8n5wTpEJs4t1QHoAJgBJA/2ItG4rR9DN8XJJD0Bgmy809YrCPZMC
	+Z/gEm4zapfqMvFOyEa8M7+5FcpIVC4d1ch4o4m0z1zQM/bp4f5DGs2lfZVHsnJDCGAlM64KrEs
	JWKGLkhPzoBf3SFfiN6X1fS38+AQQj5K4aRXdyvC5KDBxyQr03ilsV0zPTd216fusOpXxaNy9Jp
	bldkXVOXybT5hHxePhFG0c2K35qak+tGe82IdCZv7ywUYEMM1hned3/oBP1leHWVwN/gq+4gCM4
	H/E2QyxESOb232H0m+85FWaeDRyPAZ1SVD37qDaMCzabFMgRvR/suOB3oQQRPKuHnmfCDEo1Qg8
	PbLkzEO9461xzIw/NJnDmcA==
X-Google-Smtp-Source: AGHT+IEGm3fOi7RZ6OFatZkRkuK8HD72RWjYnMacH+NdmRC96egxUW7vWOrEEdTAOOfeYgZPGVaMUg==
X-Received: by 2002:a05:6a20:2590:b0:243:78a:827c with SMTP id adf61e73a8af0-2430d4c75b9mr996849637.52.1755566785206;
        Mon, 18 Aug 2025 18:26:25 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b474e146654sm2266972a12.34.2025.08.18.18.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 18:26:24 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id AF29F42BF5D4; Tue, 19 Aug 2025 08:26:22 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux RCU <rcu@vger.kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 2/2] Documentation: RCU: Retitle toctree index
Date: Tue, 19 Aug 2025 08:26:20 +0700
Message-ID: <20250819012620.14606-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250819012620.14606-1-bagasdotme@gmail.com>
References: <20250819012620.14606-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=815; i=bagasdotme@gmail.com; h=from:subject; bh=agYR481QyjyS/7Enp2FSpAI7AE9rLtWb/AeMmfEvraM=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBmLL7kFrMrxaXiw5sOZXfEV51azctbJL5U5cXWKXuzV/ 8F7gz5WdJSyMIhxMciKKbJMSuRrOr3LSORC+1pHmDmsTCBDGLg4BWAii/YyMkyr+Jyw7mii/7fY ZPcNec6PPrxawK5/KOGLQn6dgW7VRH+G//6zQ6VECg6UFjP5P/M5Hhr8RVPD/PThjtiHUTOeHP0 whQkA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

toctree index title ("RCU concepts") is rather a misnomer: RCU concepts
is already described in rcu.rst, whereas the toctree suggests that
the docs themes about handbook on RCU subsystem instead.

Edit the title to reflect the fact.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/RCU/index.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/RCU/index.rst b/Documentation/RCU/index.rst
index e1be5b3c2c6773..ef26c78507d369 100644
--- a/Documentation/RCU/index.rst
+++ b/Documentation/RCU/index.rst
@@ -1,9 +1,9 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-.. _rcu_concepts:
+.. _rcu_handbook:
 
 ============
-RCU concepts
+RCU Handbook
 ============
 
 .. toctree::
-- 
An old man doll... just what I always wanted! - Clara

