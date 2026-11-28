Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795876098;
	b=pshgySrlKjeLshYI+p2ctkHCbe5HEo2kEqwGqbYgo7YDzRMEsyh8VLMsGAJ4KXztZxBg
	 ybcZMmaR9xssttiAYzp7w//dRBA7ju1Tqepiu6Uc+0qAFYhgRpNQKlOAgEZP5rWgHk/Ss
	 TOq484L4p1Q9pucb5kqAP3eNUbfckKOYkNPHtNPlrlXN1j0RtwK2pJnWah2bFNtcZnk2L
	 kx+/k1SvUhLV8JRo+EFruuEZzCSr0zlkF9pDES7YXIXGJUwUPKW3OsTzC53xOK1QZFVX4
	 Py5jy7CegSGng3tFLRJJ2yNTXb/njhkzyWZoIPeyntC8O39MOo4iwEEH5wq5ijNYltg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795876098;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=SVXDDamLHMF92XnuX0UjakXuHcnZyMGPGvNPTWLGMxo=;
	b=qWv2pe42jePpjanrZ7RhPHqIsM6J9HApY+4lemtHf1AOAr06jL+KRlxlxCBJ4U4Cwn8r
	 D/uaIaMaMFRpAt3TD0fj8rYuWlLilcptTr+PClivl3yLgQr/MdHp7SXrfGtTU0ugZQvFi
	 33P3Sghypi8VLNLxBXtdRilZ6E/81XuC1pCInv1F6/bFqx7qCg7xvKTFAHzlM6Zt1Pmll
	 uhm1zzp0kKMGSR3JJKlVP4JF7qmWnqnAhd8m/UNlWFqc0xtwMyuXLQlW82gFw0SBEKXEc
	 fwjhlTvcoRUrPofN5GZ1D3oIxh6s1ypToaSMswAK+ExkX+IYo/DVoiZucU2M/GVKfyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ece1USJV;
	arc=none smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D8B606A31C
	for <rcu@vger.kernel.org>; Sat, 28 Nov 2026 14:28:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64D8B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ece1USJV
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b88d143160so10610100a12.1
        for <rcu@vger.kernel.org>; Sat, 28 Nov 2026 06:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795876096; x=1796480896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SVXDDamLHMF92XnuX0UjakXuHcnZyMGPGvNPTWLGMxo=;
        b=Ece1USJV+dGTn5Owg1jCUwffrcrgKvqQOTDu05sdL7GQYK+8jyRf69VgBxqm2/5Bul
         7lg1bUinaEEgR/evmcR0/+DhgsMGsod/LG3FT2aTl7uCIzYmilu//qljKzFg1udAm4b7
         E6kvEiK/GyQHvy6oXYfn+yPXb/2Q+7gMziq/DDdbPhTTtwC4d8Jv4Z8ZrDx4vA6CUf8W
         wCK0Jwp3xTgG83ABKn7epoWfhD24lO2RjOX4a0IAAsXBt6AUq2Sw3LSsEUKGUyqVGxX+
         wVv8CRWFLOxid7EXsxQvgbTP5ztWnH+018szdP4nmMXYBgnB8DTqRbJV6/hLfq0B73Tz
         H3VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795876096; x=1796480896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SVXDDamLHMF92XnuX0UjakXuHcnZyMGPGvNPTWLGMxo=;
        b=gS6mlQgE2oX5w90+x966QbybzFP9y7Ys4xWQBSi734CdD0K8R3L1earbf+KIASS/TU
         W2fyQm7U8vBfd5z36OeQbqoamva1Go0KNbLhWOFLvFHiwl+iECwB+cC1ZP3D0qWe/UF+
         gkNJTfkZKspYSZlZD7XJEOgv6dQk/dv9S7CglD21ck7msaMAWkGCjd+SR3a4D01BC1DG
         Ji8k8qAV8af0g1n/QhYXa5+QV/uOCrC2tvLLtfvCZOEmtyUQJXf6EAH9h0DA4KXFABQk
         DXmCZe9XpnbKksw/dXcGWLaylg0dXNINFYuZdjZzGwStYs4393lDc+rLgD/vX6rg0jny
         jTkw==
X-Forwarded-Encrypted: i=1; AL+hErGRZ8Ciq97iQyyj9XOrcEf2ufso0XWrQQin37rWQtpPhX81mG2zmHMvOutixvGhQhtoRrs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Q8TOQcRBxvNirYKm/rtiUNgNbGMSgbi7I4EDa9XqX27p6pYBn
	QyWRxrK0JOzZPuH6FKQ6R1IEAx5T5jPsjO8BgV8FjN2c+GSYEgVZTnv2
X-Gm-Gg: AZFdTZf/oIWReOVOCVowpGJ3fc39aaIgKkpRVyhDmQRMeQRZeqk9uggRQ9XqKG+Ee7d
	1rMMYk4ih2Bv2LV2Mt5PP2IRiuYz2XZ0tv7S+1cx/0seP+UiOgb/SbhvxAP/JRjCazJVfHqNWl4
	ybQKopX0e3ERPD5siUg9YdEQeupJSDV/U29Tz3Cu89ojYx0YW6imiPA3NvlLtpxmckF6rFjPX1d
	6DmKSfgjrid+X7Zb5tPtp9NCW/W//9jfwEPI8BYXvBAwVvs7Fjx0V3z63sHBVYum5c29AY/2HLf
	G+Wk1pKsXBnZbNhODkUwmaoutZJpZBkKP2RX6xRAKKO7tBhNwxvt7Aibr0ZDzk07gKIKlkbyRi+
	v16e2eFSE4rdkUiBomGzTBE6FgyBS8qto7tSeWJJAgTfAS6ihRW53BUOyhh//zzvzTmlsjQkutH
	t4W6jJ3XRLOhditW6BJUPGRBZ+xM0Gki2hqvB97lTejlXSrrSvXNVgwi8ZUgPwt7Q0zx1240VG4
	C68BpzYStwGHDrZj74yiQO23OGI/AaAf4Jf5gaKztXEWqizQ6j3q+QNcbvdAKPrHs6cDPZn2HSA
	Ux2vTMQZMJYFIZimWTVKRmWF1JtV9cVfQ1awthu+wHzqgLwj3oGDTHeXg2hqkZSsQoMCBCm+VPY
	zfKHAXebNgV05FmYF
X-Received: by 2002:a05:6402:249c:b0:6bb:7b37:2e09 with SMTP id 4fb4d7f45d1cf-6bb7b372ed2mr4454533a12.32.1795876095428;
        Sat, 28 Nov 2026 06:28:15 -0800 (PST)
Received: from kernel.. ([191.40.25.3])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba36e35ca6sm12448436a12.4.2026.11.28.06.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 06:28:15 -0800 (PST)
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
Subject: [PATCH v3 7/7] rcutorture: Accept TRIVIAL-PREEMPT skips in kasan-aux.sh
Date: Sat, 28 Nov 2026 22:27:29 +0800
Message-ID: <20261128142729.3756679-8-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261128142729.3756679-1-kunwu.chan@gmail.com>
References: <20261128142729.3756679-1-kunwu.chan@gmail.com>
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

The TRIVIAL-PREEMPT scenario selects trivial-preempt, which has no
callback or barrier operations. The kernel correctly skips the
KASAN aux-stack self-test, but kasan-aux.sh rejects the saved flavor
and kasan-aux-check.sh does not recognize the expected skip.

Accept trivial-preempt in both scripts and require its skip message
and a successful torture run, as for the other skip-only flavors.

Cc: Kunwu Chan <kunwu.chan@gmail.com>
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 tools/testing/selftests/rcutorture/bin/kasan-aux-check.sh | 2 +-
 tools/testing/selftests/rcutorture/bin/kasan-aux.sh       | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kasan-aux-check.sh b/tools/testing/selftests/rcutorture/bin/kasan-aux-check.sh
index 7a6f425975207..5518ca507557f 100755
--- a/tools/testing/selftests/rcutorture/bin/kasan-aux-check.sh
+++ b/tools/testing/selftests/rcutorture/bin/kasan-aux-check.sh
@@ -25,7 +25,7 @@ BEGIN {
 	test_name = "rcutorture: WARN: KASAN aux-stack call_" flavor "()";
 	success = flavor "-torture:--- End of test: SUCCESS: ";
 	skip_name = "rcutorture: " flavor " has no callback/barrier ops, skipping KASAN test";
-	skip_mode = flavor ~ /^(tasks-rude|busted|trivial)$/;
+	skip_mode = flavor ~ /^(tasks-rude|busted|trivial(-preempt)?)$/;
 }
 
 function fail(message)
diff --git a/tools/testing/selftests/rcutorture/bin/kasan-aux.sh b/tools/testing/selftests/rcutorture/bin/kasan-aux.sh
index ae7896658e94d..6b6d9971f03d7 100755
--- a/tools/testing/selftests/rcutorture/bin/kasan-aux.sh
+++ b/tools/testing/selftests/rcutorture/bin/kasan-aux.sh
@@ -157,7 +157,8 @@ check_results () {
 			}
 		END {
 			if (!valid || commands != 1 || !multi_shot ||
-			    flavor !~ /^(rcu|srcu|srcud|tasks|tasks-tracing|tasks-rude|busted|trivial)$/)
+			    (flavor !~ /^(rcu|srcu|srcud|tasks|tasks-tracing)$/ &&
+			     flavor !~ /^(tasks-rude|busted|trivial(-preempt)?)$/))
 				exit 1;
 			print flavor;
 		}' "$dir/qemu-cmd")
-- 
2.43.0

