Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC8924113D
	for <rcu@vger.kernel.org>; Wed, 24 Jun 2026 06:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782282851; cv=none; b=eIth/eta6fAzpjO1M448Xsn37IRwsMxHGoH5zxyk/EpZ5B8wE2PYqJ4c1TjTGCHMu29c6JH7bVZ+3UaPhi48ETaiOhMFKQ6cOnLMBlzhXiBaaM5fjDzY+D5F/mbKnHX8F5H5N9AdrJOPMca91/FnWkCDMHsK19X9/IEotAPWe1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782282851; c=relaxed/simple;
	bh=yFKVE1gDN/R4rptBShzoito5hCU5wF0GtrGLgkDuf8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LDP27bXRKyW0gy4X2ygm/RNXA1cJmQxU69/G7HRgu6qVuZOZPwWGPDod7kwNYXbG8UEJIahH2j0QtZ+36JFL4WS7jQTthmYT7xtzgtZmQc+6nGVWYAWsk2rcFRs7daJi0EscqAXiprg5liHdCfz330VRbFrdGGONThEfDoaG31Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+o57lgT; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+o57lgT"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c85d8615b09so382960a12.3
        for <rcu@vger.kernel.org>; Tue, 23 Jun 2026 23:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782282850; x=1782887650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EkEtFGqDPkhp9SzmiZH6fjLwhoaBQ/zMPfZFx/9Imxs=;
        b=c+o57lgTysSOAqoM6OTxCfE/H7n3spgHU3iWmBnVSY3w3/oLHlBO+we0w/xRE20bbX
         a6vl8tcDwnDeCPA2RejuQ7IN49jbE0f4MJqrssP2xdJAKPaSmfyTooaRwogPaYCIDsr5
         0RnMEuIDtZNszNBXQ5bhtNnHBC+ZnBdvJx4D8ntQ1UzGr09qfqtpk/JS1FWUoTLNULCw
         582vgyKd31TeAC5fNPli+omtNvE3Io0Hzg126kkdQ3+0q0yN6WWnf2/b6CYbKfJgmPC2
         ut6q6jZ8UqEZNj+ty5ngaXBVLJmoIVNM4sj2CYWJZpQxRd+HmSBUTdRfpsododLG9pEZ
         DmYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782282850; x=1782887650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EkEtFGqDPkhp9SzmiZH6fjLwhoaBQ/zMPfZFx/9Imxs=;
        b=NqESHHv3wC/3Pk+zRvq8e0jSsd42Gkiwc5uigwuFMcye+NBwCJDWIdMMtMS/mdl8TM
         msrlxNgg9Gxo5zpOBOVUKr2bG22ZaVK09ia/nAJqNVzi86Tj88NjGgPyzoQSSmlEeNzm
         u8glk27uDoXgSlln3El7PFMcwVP8hkhbBC7Kcin177quUTu4bJDj7cw0vo/OEOrmkqln
         qNXkuvtiHwUmW+0uzKVAc/qpbFPEyv2EBUHCG+zfz+91TKIvXctZeY3gV7+398yk4yNt
         822J0UBXvoVYUlAixO1DxpSkbaIbFyJhkIwweYdnupS58qdQwqyeJoyCKz9TstrwSTFX
         ie6g==
X-Forwarded-Encrypted: i=1; AFNElJ+CORGIfXFSphEencmiLr+gYlj0x+wa/U1K91i85PsLnrMTfiXmBR5/gz2+ipkKTXLJxTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyqAt5XnO44EBTvqGLI+ZlbOPXnZjfjePfBTkpl3TJhOqE1Tcg
	uTVOuYkGuvHa0PSzz0D2N+bN8ftHWPsdC9cfYMH+xLUOML78U3yZCbje0Hyi7LaT
X-Gm-Gg: AfdE7cnb8p4Nm/l+douj45gMB6Cyysh/2Oqe6WH30p66NMlNoUCNYMAEia9irnz4DeC
	9WtvSjMDkvdT+MkoZIiB2XEej5X/PYKVuEF4A/g2xOGWsLyru3+Y8m0C8sMqchxWo6ri0zcGM6W
	6uhVjZD/SSZzbpiPGjeSjVN9Vuo9z9mMo2q48vOkiKXEPrmk+IDnQtkuhJg/jO5gzYjGWMluZSK
	r7RCGBD868TU4ZCWYhwznhWMR8SXpH65cYR2C5Lzhz1CFn1BhRdURGRrjPWgwwjg8LT60LnsuPm
	sPb9YdVs83CduQnSsOiQI0jjljGa49s5VUy2xEwrxgex2FxoHZ4+nVB1jTGiVc7rv8NosdTlpnF
	QDQUI+/UJIF+uGAtvVWU9mbfdfMYiYAFiuRjD9bWPY2f4pTCjoP5/6wCxbwaQ/2NukL6NGYY2e8
	gUffA50jU=
X-Received: by 2002:a05:6a21:699:b0:3b2:8685:1473 with SMTP id adf61e73a8af0-3bd2cffd2d4mr2708731637.7.1782282849718;
        Tue, 23 Jun 2026 23:34:09 -0700 (PDT)
Received: from ubuntu.. ([138.199.21.246])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8bc3172827sm11544089a12.9.2026.06.23.23.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 23:34:09 -0700 (PDT)
From: Jing Wu <realwujing@gmail.com>
To: Waiman Long <longman@redhat.com>
Cc: Jing Wu <realwujing@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	cgroups@vger.kernel.org,
	Qiliang Yuan <yuanql9@chinatelecom.cn>
Subject: Re: [PATCH-next 00/23] cgroup/cpuset: Enable runtime update of nohz_full and managed_irq CPUs
Date: Wed, 24 Jun 2026 14:34:04 +0800
Message-ID: <20260624063404.2106807-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421030351.281436-1-longman@redhat.com>
References: <20260421030351.281436-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Waiman,

Thomas Gleixner suggested we coordinate, so reaching out directly.

We have been working on a similar feature called Dynamic Housekeeping
Management (DHM) [1][2][3][4]. The RFC was posted on 2026-02-06, v1 on
2026-03-25, and v2 on 2026-04-13 — a week before your series appeared.
It seems we developed these independently in parallel.

After Thomas's review of DHM v3, we are rebuilding v4 around the
CPU-by-CPU offline/online hotplug mechanism, which aligns with the
direction of your series.

There is one key difference in scope worth discussing:

  Your series requires "nohz_full=" to be present at boot (even with
  an empty CPU list) to opt into runtime updates. DHM targets systems
  where nohz_full= was never configured at boot — enabling CPU noise
  isolation purely at runtime without any boot-time setup.

  This requires making the nohz_full infrastructure activatable at
  runtime for the first time, rather than just extending an already-
  initialized boot configuration.

Before we start coding v4, a few questions:

  1. Are you planning a v2 of your series? If so, what is your
     timeline? We want to avoid duplicating effort on the subsystem
     patches (tick, RCU, genirq).

  2. Would you be open to extending your series to cover the
     "no boot parameter" use case, or do you think it is better kept
     as a separate series?

  3. Are there specific patches in your series where you would welcome
     our contribution directly?

Happy to collaborate on a unified approach.

[1] DHM RFC (2026-02-06): https://lore.kernel.org/r/20260206-feature-dynamic_isolcpus_dhei-v1-0-00a711eb0c74@gmail.com
[2] DHM v1  (2026-03-25): https://lore.kernel.org/r/20260325-dhei-v12-final-v1-0-919cca23cadf@gmail.com
[3] DHM v2  (2026-04-13): https://lore.kernel.org/r/20260413-wujing-dhm-v2-0-06df21caba5d@gmail.com
[4] DHM v3  (2026-06-18): https://lore.kernel.org/r/20260618-wujing-dhm-v3-0-28f1a4d83b68@gmail.com
[5] Your series v1 (2026-04-20): https://lore.kernel.org/r/20260421030351.281436-1-longman@redhat.com

Jing Wu <realwujing@gmail.com>
Qiliang Yuan <yuanql9@chinatelecom.cn>
