Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644BDD531;
	Tue, 19 Aug 2025 00:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755564374; cv=none; b=c/N8gJ5/V/NUElCMHSPYsYMwN1xKsyMUt1+xhoACsy9RIfy7dKXQUQIAPCQC/6hp80W2Tkm2WrGAF1LqdYwaiv8eeOu9swVweStddqE4q8hqg8Dl/0W9my5uiMNSQEy5QEimVe+c2T0OBkUdlaUb/7DJ15aBTXJAmCg6eB1XHnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755564374; c=relaxed/simple;
	bh=G3NVHyTgKHPdkK52OAVj00DmOZdNFl9ExULiSKmxhXw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s/5AmYv3/z8Wi1ybmbhfQcpEt39N/Z+kGDnjBDjYgmFhOiv2gj74HAxXrTifRFWjT8jsmJ5svB0HJk4+jmaNk5E6DwFLDzWxHUFuGsS4+Fz4o9p12hqW3+BlSBxazZh4JKQuYttp0gFG/HvH0hbvxnxf9TP4XPvUfdDvX2C7Omo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/RSKbor; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/RSKbor"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76e2e629fc4so4904199b3a.0;
        Mon, 18 Aug 2025 17:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755564372; x=1756169172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kwqgeQuU7CThFAo50DvZdBSlqn4aE79i09pcJ8nGCak=;
        b=E/RSKborZAvztr0HaTqRphgBzinWKEci3T9qTRNrFEdaeLgwAWcCaLIKh9+WwbbSx5
         7Riio4QhpBts0TKK/9mPFZBqZBipXB+UBowyiXILu1Ab4Ux+3Rio+XcTTgX3TbyHGqlM
         gOWnHbW3odc4lCVWdzKLqWLAJPF3BMhKRjphowcSU5DtTUiETZx5ZlMVF/GqZotklZRS
         BGpwAR1bYtsD9EFPMaQelJfQI9w86NJaFHKkU4V8X8NqmI7j/e/fhji0kW2MHWu8DFi9
         jZM1Sp6wcnTlFII7mUHARKyr1LXzk8pNou6tvPLjZF2NfNT6bS2s60XeP249ycxi7tsc
         1Rlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755564372; x=1756169172;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kwqgeQuU7CThFAo50DvZdBSlqn4aE79i09pcJ8nGCak=;
        b=CylvCngs9F4ZJ0ipu2VAlAh43tJk+W+92W2wPwwNeYvw0IHoX6kB5May6kB6Geurup
         +DqWj9mcLXC2N1wg6/I2Xb3vdS+DNSnx39+X9I1KZwHRt6T4Kx7bjFeNV/KH3jzjlBNm
         g4QB0ndtJ1n0zSj5lq+InGtV9C4Ap6Kv3f4OktLOaGlG7H6d4239Ry4yI0EATXwZ7ZxO
         z2N2a9t33YQnsWvPgd2hSTq0ES6SHVBN3gZXnoAHz+ZCFyPs4sGQF8jHhSe17f2KbILr
         HW3zL6yFmOYpeBFPF4lSJ8ElkJ34IC2OQy486BrvYeLBV9+8ci7Bk5jN/rr0gW6083sv
         +Xkg==
X-Forwarded-Encrypted: i=1; AJvYcCUGYYOl0j0G6G1l2HSfJcIOWF+dcyIlfItKO7P44kPZpQ61s2XFJlVjvl3l9Q920uK7fMZO+NRBBnI=@vger.kernel.org, AJvYcCUzeZPAvPk3KoOCBHwadAHU4MOF3WjZzkpOzur1VrpjgqUrMLonCvMkm0k+5fZmVuhvvmKG@vger.kernel.org
X-Gm-Message-State: AOJu0Yy49pITw81VgS80cSaB8r9G2yHMmSCYD50Nxqeqj2ZeK4a2wPUW
	di+NVQX8HA2sWjMX9+DryB4+V0nExOhS202k8CDoBWUghZZx+KMQFL8i
X-Gm-Gg: ASbGnct5/nvlbURvoYWe+yiWa+LrcppintZXeduYiHjF7cTxRNHbdO0oZrXvkZc7n30
	7bgtnXoX8n0ptUI3+53G+1M5Ooqbd64Rmy1lF+D1IqYge728AcfYIPJDJ1iP0VNOPp0SL4PEMYP
	4KkenhDtKGPTJ/lM0XPZfQElrl7PdXXDKOBQ2QPr9Xlz1bVJIQ3KhLdnktkg/J1BghivqEZB5he
	mLczXDllWia8yfRYVVeVXpuiWpel9uzUgW88wpUJgML26wOFLJ9tvoe0aYLPASnNFJ/dknhO6Nl
	5mnQgvJKRNQz9HD4oG5D3lNKfA7Z5TUMwxQ7GhrB5irYY5eLoL0IhvQyI/BjTIv4a4CLd2QYHqv
	rWsEzR7FWbXKTJJtoynRkiA==
X-Google-Smtp-Source: AGHT+IEKfFzwPAE65ZQHLYVZ8yyo8AA43sxL2irwbsjihgYcCJ2yP8wHkZS6v8N4dMYHDU13GNDayA==
X-Received: by 2002:a05:6a00:4b07:b0:736:a8db:93b4 with SMTP id d2e1a72fcca58-76e80e7711dmr698677b3a.2.1755564372409;
        Mon, 18 Aug 2025 17:46:12 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d4f76fesm771309b3a.55.2025.08.18.17.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 17:46:11 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 9ADD2423F8C2; Tue, 19 Aug 2025 07:46:08 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux RCU <rcu@vger.kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH] Documentation: RCU: Wrap kvm-remote.sh rerun snippet in literal code block
Date: Tue, 19 Aug 2025 07:45:59 +0700
Message-ID: <20250819004559.11429-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1219; i=bagasdotme@gmail.com; h=from:subject; bh=G3NVHyTgKHPdkK52OAVj00DmOZdNFl9ExULiSKmxhXw=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBmLj3f6eKwI0q5jMzkzw3J9e7Th49xL4n5Mhuxi919qX b2ryGbfUcrCIMbFICumyDIpka/p9C4jkQvtax1h5rAygQxh4OIUgImcfs/wz+xtfVuEhXERc0NY CrPGdeV4zdr2m3O3rJ52dOtXJiO/fEaG1VeOtRb3TytyS5jCwC/cNulM4+eWS2HhPxl7F0w6MFm bGwA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Unlike other kvm*.sh snippets in RCU torture test documentation,
kvm-remote.sh rerun snippet isn't formatted as literal code block,
causing it to be definition list instead in htmldocs output.

Wrap it like the rest.

Fixes: 0c208a793022 ("doc: Update torture.rst")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/RCU/torture.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RCU/torture.rst b/Documentation/RCU/torture.rst
index 4b1f99c4181fee..cc57d01ed700ff 100644
--- a/Documentation/RCU/torture.rst
+++ b/Documentation/RCU/torture.rst
@@ -364,7 +364,7 @@ systems must come first.
 The kvm.sh ``--dryrun scenarios`` argument is useful for working out
 how many scenarios may be run in one batch across a group of systems.
 
-You can also re-run a previous remote run in a manner similar to kvm.sh:
+You can also re-run a previous remote run in a manner similar to kvm.sh::
 
 	kvm-remote.sh "system0 system1 system2 system3 system4 system5" \
 		tools/testing/selftests/rcutorture/res/2022.11.03-11.26.28-remote \

base-commit: 61399e0c5410567ef60cb1cda34cca42903842e3
-- 
An old man doll... just what I always wanted! - Clara

