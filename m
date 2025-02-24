Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A7823372B;
	Mon, 24 Feb 2025 13:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740404227; cv=none; b=U8bNNhBbEZd9QmXLh1UZoXhn/bHIEomF9u/43x36Uuti0NtOrdtNJ60n+cvWrxTasNcLL2OuNoU9WyxD4VVxUILTmUGPN4t5FFtaC8pzi1cCqOJWw8FdPKOhSYke7rKwQEVSjLSxKGrWfXHfFx1YcvigcFLskR382VmFntShruc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740404227; c=relaxed/simple;
	bh=sCuflgFUh/45tShowZi3ebLKyBuj3+UPfLcwZ/CRsbA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lEoIjLwygYsNUODBNaXw0UpJvTXRkxeRCYqqcilvZfVRweZ3PR6QhGtFV+wsSN+vsJHPomW+crCD5CQGWAVoFA53d0s/W/OfihVje/DKT3rd/n+SqmRtw3ZVd1j1ulnWSJtmUdzXTwr1ntkhjF95iFEegk9JhuifrA7lFscx/84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VPIrE9Xi; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPIrE9Xi"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5461a485aa2so4070270e87.2;
        Mon, 24 Feb 2025 05:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740404224; x=1741009024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8AAp3JK/Rr4QIILXNDXheLWWABxs1/zeQyrDjipUFA=;
        b=VPIrE9XiL6arzN31khRKKuebcVJKd3Q2arUoTkfu9N2entfBjVKSchxGcoVyG4xPR3
         QEuO+jWU94nYpPpl9an25ptTjMCNvTfFoLK4WUZPYC3EkKVPsB8E8kjp+aMxksVENXS7
         QqC7kOFTAa5dHLjPGa+KTB1k0nk8dddIdvhxFw4BflUPNF72kNRMi34Kv2gUsyPHI++T
         nZBzszAzT2tzfQJi06/N56v2HJW2JO+06tVxSv2m+KoRSl0/wtvsznfZ6/SX+Hx1ET5r
         OBuAaVGTInI4WlXDTiKhk+CMdvvubQDrt8eN8vvvdbqKR5KkcKZThQcMWBauflTRpduf
         C6/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740404224; x=1741009024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c8AAp3JK/Rr4QIILXNDXheLWWABxs1/zeQyrDjipUFA=;
        b=Nvk+jD0tJYFPrP/aI9tEdVmBnXeTQwQ3OXL9RAo/eybVR//5+WMuSagaOerMc6gHjm
         Biuo0m6eMFYbjsFfz+VNs8TqdcG7gwpTslHrmQyK+4pEbkf90bxKKXbTV7BUtwYyYeAM
         y7nXVH3AZmAm3VOMMsHs7hB/4c/XlI8L/wgOg3HOSs75za3GIAag3dXrDc3BCN2Au+EZ
         mkYkqSPM0tMTKO2Ud35CTOpbUmb5Fa34umhlEziz5b4klimkb0KCdpyE6CVbC/MV+S64
         PGVmzS3AIA9Lwile7ufv0YfX6VkYKvMKZWDUPouEMElRiNLH8bmEUExjXcE00S2lgZzE
         uh2w==
X-Forwarded-Encrypted: i=1; AJvYcCWs22oCpiDDf7UJXZZ0Nih2lqCHb34VRTyy7E187Z1tarpqbQ0qQvBudYrjj3WJTHIGBNrQxYjepavu/Z0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3MuJy4qe4eisq2b4sqk+vKRwWp0rF0N90NRsa+v9CmsrInKqN
	5liIL04mhxtn3G+0O2UApG3y8d+NXsIxfr5IX4fHqgIDU1da060u
X-Gm-Gg: ASbGnctsdonHROPrKacfDUv3y7JpHJRqAOh4PrnDx9kOlzMZa7OhwD+sm+w6xjy4a7b
	0UZTdfzAc8ZociEgBVHWyBA35eIXYUZ+pmwFnnFTacK0BdWkvllTWA7oL1KCXOQBugCnYLABZBJ
	6GdVFOjCPL1T7751QxB012+H7+shi4NJpslI3E+dlbrQOJoVIkPH6usGIeAiZ3GryDnOiN/lupF
	Ucu5aoDYfApDNMnywPYsijrquozEhPshCzUUUz1F4wj+gbJrO0KNl2dGJmCqj6ZZYgYYaKo4n+9
	vOCPHOSGxGM3N6S37m8ZDg==
X-Google-Smtp-Source: AGHT+IGvb98xMoDkb16VRq6TsgBIQrDI2uk9mhm0fZPOnTDrl8Z4JPeyRurmrJrI3hJdfJKilNKaAw==
X-Received: by 2002:a05:6512:3b97:b0:545:d70:1d1c with SMTP id 2adb3069b0e04-54838ee2993mr5839079e87.11.1740404223297;
        Mon, 24 Feb 2025 05:37:03 -0800 (PST)
Received: from pc638.lan ([2001:9b1:d5a0:a500:2d8:61ff:fec9:d743])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5461eb04602sm2424799e87.68.2025.02.24.05.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 05:37:02 -0800 (PST)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: "Paul E . McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>
Cc: RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Cheung Wall <zzqq0103.hey@gmail.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH v2 2/3] rcu: Update TREE05.boot to test normal synchronize_rcu()
Date: Mon, 24 Feb 2025 14:36:58 +0100
Message-Id: <20250224133659.879074-2-urezki@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224133659.879074-1-urezki@gmail.com>
References: <20250224133659.879074-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add extra parameters for rcutorture module. One is the "nfakewriters"
which is set -1. There will be created number of test-kthreads which
correspond to number of CPUs in a test system. Those threads randomly
invoke synchronize_rcu() call.

Apart of that "rcu_normal" is set to 1, because it is specifically for
a normal synchronize_rcu() testing, also a newly added parameter which
is "rcu_normal_wake_from_gp" is set to 1 also. That prevents interaction
with other callbacks in a system.

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 tools/testing/selftests/rcutorture/configs/rcu/TREE05.boot | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE05.boot b/tools/testing/selftests/rcutorture/configs/rcu/TREE05.boot
index c419cac233ee..54f5c9053474 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE05.boot
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE05.boot
@@ -2,3 +2,9 @@ rcutree.gp_preinit_delay=3
 rcutree.gp_init_delay=3
 rcutree.gp_cleanup_delay=3
 rcupdate.rcu_self_test=1
+
+# This part is for synchronize_rcu() testing
+rcutorture.nfakewriters=-1
+rcutorture.gp_sync=1
+rcupdate.rcu_normal=1
+rcutree.rcu_normal_wake_from_gp=1
-- 
2.39.5

