Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793811561;
	b=KZIRQA3alOrprgP6ldi1pMTsIQhsllD5pX/JcaUqXMnHemN1MaMR+oXFWChMvEiU5HRg
	 iU6eCIEQIc4lO3T/UNVb1PFmeV3wmc9qITLyytQuWw8B78xdkNWcsk0yPHS1gxUhv3J9y
	 Tyb+vEHfFYhkipST7/7FQov8m9XS1vc39/XLSSuL0+jqToJxzenEDeqCA1kyfENZMwyoC
	 p6XCInbFtiesI4K2r5Jjejsdn2qRpwaXG4UZHbDR1oAtu4Bzg9YbuhARr7HmBRuLXIOb8
	 BU4YwC/e/W1ZvzjiB91jgZZSAokDj8zpBb7XsX468REPtAcIWTt99u1IdjqONRW5QaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793811561;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ccVf83RTacEiSDDfp2h5xNH+o9FDf22bxraZEScVifs=;
	b=d7+YXHxPK3PbfIJ0qRI8JfgKGxQ2MGKQOYv5/ai2qK6kHVDKURi78el0pxt99l5m7N2A
	 oOSTtuYeowTG7pFrFqwJtGX+l7JGx3AH0CWcY7LAW7safoEOvELqTPZmao0oaSyxUATUw
	 mgbKJEjPd/oyxFuEAgXm7ANeePMtevtnXOsCI8DJo1hFmUQiQYEL8HwrIAvGEmszLHJt4
	 7UwG9SMIoVjLfQ7N/4lFMHfMuVLjm1j39v9eeUbrm8cGYSl0NaiRCVKkgWZjN/tkEzyIk
	 9BT5CYXya5atvakE6qqCc0VrgVCYy3UU9kIjDojHD3d3cDTRQEMlZDwSoat4MjBDCug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=srwPcV0C;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E761606EE84
	for <rcu@vger.kernel.org>; Wed,  4 Nov 2026 16:59:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E761606EE84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=srwPcV0C
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-36d6e342f98so876941eec.0
        for <rcu@vger.kernel.org>; Wed, 04 Nov 2026 08:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793811560; x=1794416360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ccVf83RTacEiSDDfp2h5xNH+o9FDf22bxraZEScVifs=;
        b=srwPcV0CMrFf09RumsTb6kBXvwJSmyv7F6Ok6cQb4RLoNTiP6mDJJ41AONoG3IBegg
         379AGoSfjaRazt2ZxU+Y67WdxSbYjW8t6oX0gLgWERE6FMNjvMjXxcOd6Ktdnc/OnQhg
         7CkFVW/HO4lzzZI6IXqVLY7dzdszcT4WWgR0uw+rX31a1/YYlmIrQ8cwUbAIuGACbM6w
         vKAA4UG+0TPX7jAJmab/BP2MApuRxmhM4c5Sb5Z5knQDN6HhMTR9IWNkB1xVYiZxbAIe
         H2FBfin851fcltS4cy0iogqxcy8G6CzVVIxlrmHwDWg2Y/Rj6tiru7Gg2HoezRX+hjYr
         SwRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793811560; x=1794416360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ccVf83RTacEiSDDfp2h5xNH+o9FDf22bxraZEScVifs=;
        b=YrW7rL+R8bdNU12bwlL9Sxlg+rUBPNSSBv1/WyYB7550UZ59Q6TkI4Nnu0BBD+eh1z
         +LnuPxNlU++WE1jRH8yFzrbslNns5Yt62bm+9nbHaKxEzNpeokk0RpVWSNpfb/jlkeTl
         eAunffI8wOp5sd/rQjGytZgFpYTIuYK7SjTN4GTONKVql6/KlDK736iLNShi2FyW0dQh
         Ry6n+8e6soIr2NXdloubrF3w/wb1ipWAhvLb4OCP/VGmaSs9tayuJnq7VrB6zSjPhThN
         pyirzEhg1nWYyG3T2RFN2qI34mzBj/34Hp5bv1nTEnGMc1VeXG+IiY6jARwWu5p+0y2+
         KPMA==
X-Forwarded-Encrypted: i=1; AKwUvBzg1RpAsIVeb/txOoZAkAHIH31eASkmU+GUt3oR024XAvoVG+0672WEaxg5cGZ+T4CAFag=@vger.kernel.org
X-Gm-Message-State: APuU4Z/9e3qYaW7APfgpysHwqEA3Hc6M9d3p+W6tIEX24LXfJmJN+MMH
	1NX955I5q4U2GMC8Vdr6FkY5bi8AjEZYvizt6dePg4ibX1VK5pn2QATU
X-Gm-Gg: AYBFou1d8vsp6YXtexn2M1FsF1Ih2s4I+ISajdotyrJLnfdaje6S7fbz1Breo39cDgf
	rrP2PAbALxpGjVyrgI/9WcyyAdLvGEXBhqATaaWkUaeJ6P6NkBsWLA/SmQ/47IDosLXNti3id1s
	bKk6ILeyyGbqoA25lppivK8opabramEtPEP6kJpx2xty4XEsw6I6WHtYWmjk+XJ7wRVZ3yulwPZ
	MA1qioBO+8sFWblN9duT8dwj7jcgRsbwSpLHcjWVYzUewjXSaksVDoO8jCIFCXvLwGDo3Lmy7p6
	hBFlMmi9p3HKPNQU01sDu4ZjbVBVtBjyL50TPtNdng4V4HVPeUNF4OozJd0iDCUxTEUaROUuZKs
	7/U0wTgUMELcV5JShQouKm8GT5A6KP/kk/eBWd9Z1PplY52iSGHvCFIOdGQGqPBtXIpzulY49Tg
	KjcNyfRqRywGRSqdVj6oTHrEVfiikZApv46JwFrnIF2rF2DQPGp1oHwQ1ZGjiozH7Rzo8BddBrU
	fFbUzYiVkOHSupWpckcJo36+fIpWrkNScoSlPpPQVB07vT+Okafg5MEvUQuBKG0YYLyUfw71jzY
	YaNDOTs3sKOHEccPDDaqgvTwMQyyU5Tw2ZKNgDo=
X-Received: by 2002:a05:7301:640b:b0:33c:16f1:2e11 with SMTP id 5a478bee46e88-36a42363ef8mr22540460eec.7.1793811559006;
        Wed, 04 Nov 2026 08:59:19 -0800 (PST)
Received: from kernel.. ([216.195.201.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38d46fcsm9019567eec.13.2026.11.04.08.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 08:59:18 -0800 (PST)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: paulmck@kernel.org,
	boqun@kernel.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	corbet@lwn.net,
	mingo@redhat.com,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	josh@joshtriplett.org,
	urezki@gmail.com,
	dave@stgolabs.net
Cc: stern@rowland.harvard.edu,
	parri.andrea@gmail.com,
	will@kernel.org,
	dhowells@redhat.com,
	j.alglave@ucl.ac.uk,
	luc.maranget@inria.fr,
	akiyks@gmail.com,
	dlustig@nvidia.com,
	joelagnelf@nvidia.com,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	longman@redhat.com,
	rostedt@goodmis.org,
	qiang.zhang@linux.dev,
	kunwu.chan@gmail.com,
	brads@mainlining.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	lkmm@lists.linux.dev,
	linux-doc@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 26/28] hazptrtorture: Add torture_type=none clean skip for rcuscale coexistence
Date: Thu,  5 Nov 2026 00:54:44 +0800
Message-ID: <20261104165504.2430480-27-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104165504.2430480-1-kunwu.chan@gmail.com>
References: <20261104165504.2430480-1-kunwu.chan@gmail.com>
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

When both HAZPTR_TORTURE_TEST and RCU_SCALE_TEST are built into
the same kernel, hazptrtorture calls torture_init_begin() first
and rcuscale fails with -EBUSY.  torture_type=none makes
hazptrtorture return early without registering, allowing the
rcuscale hazptr scale type to run in the same boot.

Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 .../selftests/rcutorture/configs/rcuscale/HAZPTR    | 13 +++++++++++++
 .../rcutorture/configs/rcuscale/HAZPTR.boot         |  1 +
 2 files changed, 14 insertions(+)
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcuscale/HAZPTR
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcuscale/HAZPTR.boot

diff --git a/tools/testing/selftests/rcutorture/configs/rcuscale/HAZPTR b/tools/testing/selftests/rcutorture/configs/rcuscale/HAZPTR
new file mode 100644
index 000000000000..c5e9cf0184ae
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcuscale/HAZPTR
@@ -0,0 +1,13 @@
+CONFIG_SMP=y
+CONFIG_NR_CPUS=128
+CONFIG_PREEMPT=y
+CONFIG_HZ_PERIODIC=n
+CONFIG_NO_HZ_IDLE=y
+CONFIG_HOTPLUG_CPU=y
+CONFIG_DEBUG_KERNEL=y
+CONFIG_HAZPTR_TORTURE_TEST=y
+CONFIG_HAZPTR_DEBUG=y
+CONFIG_HAZPTR_STALL_DETECTOR=y
+CONFIG_HAZPTR_STALL_TIMEOUT=1000
+CONFIG_HAZPTR_DRAIN_ASSIST=y
+CONFIG_RCU_SCALE_TEST=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcuscale/HAZPTR.boot b/tools/testing/selftests/rcutorture/configs/rcuscale/HAZPTR.boot
new file mode 100644
index 000000000000..e9cca4cf453b
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcuscale/HAZPTR.boot
@@ -0,0 +1 @@
+hazptrtorture.torture_type=none
-- 
2.43.0

