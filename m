Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74D913B280;
	Tue, 19 Aug 2025 01:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755566788; cv=none; b=VOJ6dAyVk7IqnFPdowX5gjgj2vQi9Vgu9hSEcLD4BstONkUc9XH8Kib2Yx9hp5W9td79MfgZRhQW5MFny6sM///0FMlpdhYy4J8TlriReypbovF+PHXnMW1Q1W5uGtBqJfTgzJNfinbffgOTpPk5S2guPUvm0x8Q2++XKBDP+k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755566788; c=relaxed/simple;
	bh=yThv/fLDuCF2BiJFvrSvw3XdJHpXPBmCZesHAy+IgUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ULmysWbG/yptUqK0a2aCAM21uT+53XGzv2euB6B8Jed3fu8j11sgTFfZcU5XksFfIiU+RrxWw6njGj6JLmAesEjiYBaIw+wIeIY/bEXtEcLOWv6N1l4lEDtOzcTSaC2fU3QyqdWS9Zy7zHUaV6BzRy1lfwGrSZXhf8xOhkLp0Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GvLTSByD; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GvLTSByD"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76e2eb9ae80so3645605b3a.3;
        Mon, 18 Aug 2025 18:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755566786; x=1756171586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xZpGo7axqX7Cn80ts/kx8vWoCJakALAD019/VmqMZyo=;
        b=GvLTSByD9gV2xRhqZ4QXqwUg7mYFK1j9vsXJAZKNo6jjzUOOPBkWMwuVijK8NDUaKt
         pUd6ZFGzEgbEv5Izy0YVEhtsFCyTKkZ+uVoFu8T4OAwS55CbU6UknXD5/yHr9ZR4jynF
         UetR22MZF5ZsKW+j1v/iXij/aUEA/UgJAs9Y0uBAk1DcRb3m2+Teag4+8aOPgCEotrNF
         PFrRE1a+KYG60Jg3x26ZrquSgka86SYUwtTHiAg+GOGgtxJAcPlZwAxw1S7P2zWpsQiP
         utOey56BU87lYgfVv47lIypgs+JDrjEHOnAXG1Hty4E3YFjK03RR/Aqz1O+CulVoA5zF
         sNRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755566786; x=1756171586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xZpGo7axqX7Cn80ts/kx8vWoCJakALAD019/VmqMZyo=;
        b=oNpasx573JIhp8j6o+cOw5hH7uM03Q6QPOp+Mehc2JZL193loXLZZWXjFcAcpTwGI1
         HSuVLnJwiJqlyM8z00yQE78e6GQDo/JsZ07LH/tLHpJk3RzZ5DbnDiEhC+nzfb0oRliG
         BvkWo/jXP+0FyjD3juk4TNJsZWsCVmUUwTBpqJGy0wzCza9B0sphiyc5u5ZwF7ty6/6T
         pIacWT2gImcnFmEk8NpIkFcr0aCplEkLvuT6Yp9z/n+cA6NWp5tAzDrSdWxsG8t+bq50
         ThQqbta9/U4ZRMv71rJR6tGJWqGrDCBLYsNC+zqdZE7qh51VCjYSXyHea/b3+k3wVOl2
         eFBg==
X-Forwarded-Encrypted: i=1; AJvYcCU64UOAs3/2rqgnQtqsOUxodOsUDXZID9Iz1N9QOzEggLAnQq+CExoHxbKBd6IRVvccib2V@vger.kernel.org, AJvYcCUXteFDzKb3+5egzUctxzimIg7lKJVC8g9lihzttzRMy3Scgewmz8DOS9orZaWPVYNGuolo7FHU8l4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzeh7FhMEbtdiDHahY4Ua/v7QJZTpXGA5W17U5RAZ3kMYZP1fR8
	eh+WcORyycPDWwrZwfxkkOCdZeusGtVO8JhkN92jBLBp56Vq1O7AXqMx
X-Gm-Gg: ASbGncspXdbbrCsW7UjHV8B9YXhAvFDTB8mv/CMcjbYf/bM8K63h0/yVvLcTK6BDwGa
	G1QR8EvwGeF3PV7o9c5/SPae3fNCOqpiBrqihE7kbwheD38y5IqJ9OUADpm9JXkA4c/CS3FGNz9
	ONTGKRRsymEk74nc+R8cn7JN0kbkAxDcpEXDkxhoGcS6dPkBU/SEh7uHj53rUJoB41Ub+Q2mYal
	y27cZclXliFT4oDJvAwenBN2HU8rWbqMd+X/0FU3V9c9d+z+lq+XC3ZUJ/HZYUdz1omGDYWDQ6y
	84mHPm1om7tJSm/RdninfMczuu6yXmPoK1WdgnRzJ+Ku1d4NgLenUmkuOaHAefiv5r53ijk80Qv
	MeKSb+Am9AlZKYDjw5LKYrA==
X-Google-Smtp-Source: AGHT+IGL1d7sGb29yjR0fxMdmAFVMQlz7PhC5pFqqGDWP8f4gOBJBrea4w3afbpUpu54nzSA4aJ0bg==
X-Received: by 2002:a05:6a00:17a4:b0:76e:7ae9:e86a with SMTP id d2e1a72fcca58-76e8110951fmr753820b3a.26.1755566785983;
        Mon, 18 Aug 2025 18:26:25 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e830d3558sm136093b3a.75.2025.08.18.18.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 18:26:25 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 8BDD141A38C4; Tue, 19 Aug 2025 08:26:22 +0700 (WIB)
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
Subject: [PATCH 1/2] Documentation: RCU: Reduce toctree depth
Date: Tue, 19 Aug 2025 08:26:19 +0700
Message-ID: <20250819012620.14606-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250819012620.14606-1-bagasdotme@gmail.com>
References: <20250819012620.14606-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=794; i=bagasdotme@gmail.com; h=from:subject; bh=yThv/fLDuCF2BiJFvrSvw3XdJHpXPBmCZesHAy+IgUE=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBmLL7ml1spb6J+7PEf+WiXLlsRXB8su72forrLLaep0E Pq8dl53RykLgxgXg6yYIsukRL6m07uMRC60r3WEmcPKBDKEgYtTACbyyIjhv8eLgG8TbS2c1NfL 1kg+/Hh31WSOwAVFRWz5i2zmcBgkhTP8Mz1zvnDa+cyD24zfMP08e/7NGtODDM+f31HaeTdu1hR RcyYA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

toctree index for RCU currently has maximum depth of 3. Since no docs
currently use more than 3 section heading levels, this effectively spills
the entire docs hierarchy.

Tidy up by reducing toctree depth to 2 (only showing docs title and
second-level sections).

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/RCU/index.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RCU/index.rst b/Documentation/RCU/index.rst
index 84a79903f6a883..e1be5b3c2c6773 100644
--- a/Documentation/RCU/index.rst
+++ b/Documentation/RCU/index.rst
@@ -7,7 +7,7 @@ RCU concepts
 ============
 
 .. toctree::
-   :maxdepth: 3
+   :maxdepth: 2
 
    checklist
    lockdep
-- 
An old man doll... just what I always wanted! - Clara

