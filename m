Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795699560;
	b=E80LN4+Lulg6NJ/ro3hQIkKveocR7ga/FhDnT3zYTIlPbnBV2RmUnLIzwqhs66gtyquU
	 +Ct2p2cJuSW3kpqYr8YGVBGLBnE+sDagUSdlAsLYrEk1ceRZHdraRJUF/49TAxdjNe/tq
	 yga1eworXeZsnkVc90/N7PNI4pB1tQnJm877NM6vngixA+EcgD0ifC/dLkHnNAPk6wqbz
	 94DVs55yyUwVkQ/RiaAD3ZL+8Rie43SmvNg7O7+o//qQTsgOCESPFQmQUi23LKufDE0hh
	 KobWv7RxIpU7mE5TD+teKWM/wpP916e4rtsQzAXiB2d6f0ToOTrdIYZ/CSaPxj57NsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795699560;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=VoBEgiO3LGgFu0I+CoPOV18doel8Lm5xFkwPKKF3UjA=;
	b=Omp4fkz/FuSTVUfX6LjdaTUzsFAWVM3NLXM59t/jsu+4x9w2ylgIrDPOcDlbi+wkJ52S
	 ab3i3Dm8W8IuJfJ9neLXjkND2gMhj5Dm9ZnEiGyawo0YlG4ELaKdRsrvqHK5rbNaIK1ip
	 mC/aJGuAo7VAnDd4Wzln95fHJHM3V8V/k3Qtw2jVyHFS3u5myT/SktNLhvfP23WOBAgMa
	 /QynamIw3ITwyjeTC+463cnEBo1lbZJfm+AUloxPJIQR82zAcRW8j8xXU3lNhp31G8dn5
	 JggmkGBD7NKBYffFB+77vPcI5Q1ZypOkc1JrXvF0VEqjlizaspzwilYI6ea11/W3qmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Y9rvqaFD;
	arc=none smtp.remote-ip=95.215.58.130
Received: from mta1.migadu.com (out-130.mta1.migadu.com [95.215.58.130])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60ED4606A323
	for <rcu@vger.kernel.org>; Thu, 26 Nov 2026 13:25:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60ED4606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Y9rvqaFD
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Mx9tj3Sgy8Z6jSByFbEw5wqlOsU+YsRRPEnrf0b0edI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795699557; v=1; x=1796304357;
 b=Y9rvqaFDtdwZB4rAi2kkOLlEU0MKeOql1Z9irBp20AYr6hqYlB2NX6WdwHy10k67cqUFEv83
 SfpgumNF3vuPq91qDvKKK/OypyAg1PP5OLVZRJ+XqfFo3R3HoQAsYMZfGaAuPuu1VCUw1fR/hf2
 9v3BdGFVhsKonyTYKKDpWTVI=
X-Envelope-To: rcu@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id a8713e5558b39bcf;
	Thu, 26 Nov 2026 13:25:57 +0000
X-Mizu-Trace-ID: a8713e5558b39bcf
X-Migadu-Flow: FLOW_OUT
From: xiongwei.song@linux.dev
To: alexs@kernel.org,
	si.yanteng@linux.dev,
	dzm91@hust.edu.cn,
	wy@wyuan.org
Cc: corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	paulmck@kernel.org,
	linux-doc@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiongwei Song <xiongwei.song@linux.dev>
Subject: [PATCH v3 0/2] Add RCU docs Chinese translation 
Date: Thu, 26 Nov 2026 21:25:20 +0800
Message-ID: <20261126132523.6329-1-xiongwei.song@linux.dev>
X-Mailer: git-send-email 2.52.0
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

From: Xiongwei Song <xiongwei.song@linux.dev>

Changes in v3:
	- Some translation improvements.
	- Deleted unused label.
	- Fixed indentation warnings.

Changes in v2:
	- Fixed build warnings and errors for both RCU/index.rst and RCU/whatisRCU.rst.
	https://lore.kernel.org/all/20261118131636.5131-1-xiongwei.song@linux.dev/

v1: 
	https://lore.kernel.org/linux-doc/20261113013054.5662-1-xiongwei.song@linux.dev/

The following 2 patches are adding RCU docs Chinese translation for the first
time. 

Currently, RCU is not listed in TODOList in subsystem-apis.rst. I propose
adding it.

Thank you

Xiongwei Song (2):
  docs/zh_CN: Add RCU/index.rst translation
  docs/zh_CN: Add RCU/whatisRCU.rst Chinese translation

 .../translations/zh_CN/RCU/index.rst          |   50 +
 .../translations/zh_CN/RCU/whatisRCU.rst      | 1218 +++++++++++++++++
 .../translations/zh_CN/subsystem-apis.rst     |    1 +
 3 files changed, 1269 insertions(+)
 create mode 100644 Documentation/translations/zh_CN/RCU/index.rst
 create mode 100644 Documentation/translations/zh_CN/RCU/whatisRCU.rst

-- 
2.52.0

