Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793811386;
	b=nW3fxrLjGV8pa3u+5bYOXXd47eFWR0dbSo5NoC7AWtxJO53Cw+ErKS0VRTnNJMUIjEh/
	 ClasXmk4Abs9LgKIGjHrg81AiLJ4PoEQ4/T6yFaRbit8xgxsdsCyeiJDySX7f82DF7d8m
	 VK/PYlKwqCtibCfq5srVD14Z2XoMWmTrM6fItfy8fZBhZVK/FN0TS5B5tkJ7WgaeS3jLr
	 luzc92ZhQgHjeEvmT/akirG2Cha/hl19sy06zHLfGfejeGaWXziBkc+uw41YNT1RF3agY
	 /XTjU37UZMuOpOJAfQQ1gOVxA/vEAs8nqmxg02885DqHBTpGYGKZnzGvkmKBT62duLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793811386;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=UXmgooCun45H9nlbuiuwQFHR9S540n6oe4h3LrE1mlU=;
	b=x2DrWVV0tS4OuNZ0ogkBXXDpEusgTCzJV0VDgktgkQz+bKJV/NSegfDW/XJdmXlHIbfP
	 HUKDB2YnOHa6lb9mLqn/TaNGY00fy62xsNfkq6OkaFx6VyLWnA0L3ICWwBQUsJSDhHleF
	 HslKMXlGACSnmJdWaFdIS9i6bvUV26Xz86ZNeI67ADBs0tSw1ZZTDYHQ/MWIQLC6GTkO2
	 OxylWUOvgRYOfty8jv8YBgl5tNaaaCxk0ULYvlsnepzry9umKNfa501gX9Nt3PiI80RU0
	 THmptVac9Bg67PVymlOjz9cnDEHqYbxiWRv1APiExxpiseZH39iGwHEexYS91f2Pc7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ds9ImoNF;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099CC606A338
	for <rcu@vger.kernel.org>; Wed,  4 Nov 2026 16:56:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 099CC606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ds9ImoNF
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1931ff67a29so629069c88.1
        for <rcu@vger.kernel.org>; Wed, 04 Nov 2026 08:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793811385; x=1794416185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UXmgooCun45H9nlbuiuwQFHR9S540n6oe4h3LrE1mlU=;
        b=Ds9ImoNFnqIw6Qw1Xrge8SkX9ej0FZa29MRVRM8wFsA0dQhuXWwqhtoYP7h4kad5e+
         CujAQIMvVoW8e/ktVA4RJkhE4uKZXGsISnstiGMOLDEmO9nifwT/0JQRpt004gFRJZka
         aEN6hIa6lRyLDyjswYqiyD8FDsS/G+5MA7geCMPJHINQ1V8ZqZdDIveb0rMC984y8KI3
         eR95uJTOaQOkLl/fbaGQHrdaL5TBwFQZNwuQsEHOhhRuT4aizhsDX+zooDipclNZN4so
         bW+qgoLjH1gb/KVmb6CxV62RY4uS8XAiAEaBZKn2+qXwuceGSXYh9D9dKoNtagpVAIhu
         D+qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793811385; x=1794416185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UXmgooCun45H9nlbuiuwQFHR9S540n6oe4h3LrE1mlU=;
        b=zSkHiRlcdS6poudKXFcgm7aP+/JbLIwFjrLpctfY2Wl9bOzYItp9eXRIgfP8zd4xis
         Cqt7ItxeNjMlafWM3Ym9cRhOglzlmwkjVf2Y0VbsrG/TBb+0TQbnoNR6CJqXSrnWMM8m
         kuqNaQQilMdBxOobGsQCFKctJjoOfhg0EDpZfBJF6JHK2il7zWGndt0Y5TkSSxt9A6eJ
         zcV4Ud51LS7q+IOZ/nuabIIpoNelZybIT3jjANnFHHk6azlUt0oOkchfOHMeAAyCc3NF
         3wzWEkINROewzBhQEhXLFAiwYm6QrcjuTaaC78bBIoQVMcTVi6Z0MJbyEwt4n+gxBnZ6
         w2AQ==
X-Forwarded-Encrypted: i=1; AKwUvBwP6PVPX0Ha1AZSz8ac2IQKlJ0nysQ24aBRXyQ7I0pfXgx/Pt8Ki8ZoWG90B/PPnwjveqM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/tzx+WqbMY0dDhuZDlkaYF2EFWdYtL6+n0N9bA0LzgbFtm+iOC
	18ucwmd54F79CCXxHnFP4EUXmFpQT26Lo9bPwlnseCpnNR+Am7PZKs4rIm3zppyBfLsyUA==
X-Gm-Gg: AYBFou0Ir78W97uptokdra878JigvfKl0BjUetYznGDY7QZYc6GdoAN3/lXHX9+AAxS
	b1hdMrD7fomZYAgqeWfhZeTfigVQ7zqLwt8Kym4AGCqOsdixGuIliY1HR6cVtKRlIUNGEjqHctX
	583SrPkTB0j4E+kstmaVnu9LPd3FNGO9b4qRiMZ+X0WAK/JWmonnAz/t97xMr0KsOrOxkt0DJK0
	/gFzD4SLCLSJAuRIceLb2uK9tk+LsHSXlfk1i2TJt+2ZzTrAK7PX6S/YKVCfdGJasekBpI/kSTN
	xgNDTiUnXD5ZBRFIF676nPXRgW8xLVSsVUvOwNO7clUYKt7nJ/1ON+SaooeTs/Jwzt9EmxZdBZR
	ikDBFVqt5qRpJiWvRCxpJBTaT6BgtSHtrWz8Qm+m6rsNL2T8MQIKx+FFV0Wqp12gK+o1KabzRXW
	YYCTiMnFImS7hRDQtiZaEzji5J6hW0WzhaJA3ZdFySBWc/PcFCiPWYVoDabkrwAu1SAt2Fe5lAU
	wYTTE7w96mTwobW+aNdym22enrMfz9yfDw6ZNqnpdP+Ecwrg+JhRcmsxiSrMWXyglF0P06S/gfx
	MsAHroAJSO7e84BnrJYQklk3OvgbO6K3lVKj9C4=
X-Received: by 2002:a05:7301:3d06:b0:358:eccb:af7c with SMTP id 5a478bee46e88-36a42404840mr36237962eec.33.1793811384606;
        Wed, 04 Nov 2026 08:56:24 -0800 (PST)
Received: from kernel.. ([216.195.201.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38d46fcsm9019567eec.13.2026.11.04.08.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 08:56:24 -0800 (PST)
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
Subject: [PATCH 07/28] hazptr: Fix kernel-doc of hazptr_release()
Date: Thu,  5 Nov 2026 00:54:25 +0800
Message-ID: <20261104165504.2430480-8-kunwu.chan@gmail.com>
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

The second parameter of hazptr_release() is named @addr, not
@addr_p.  It is the address passed to the matching
hazptr_acquire().

Fixes: 17969a0e7f7e ("hazptr: Upgrade kernel-doc headers")
Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
Acked-by: Bradley Morgan <brads@mainlining.org>
---
 include/linux/hazptr.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/hazptr.h b/include/linux/hazptr.h
index 299ad8a07156..0fb48518525b 100644
--- a/include/linux/hazptr.h
+++ b/include/linux/hazptr.h
@@ -315,7 +315,7 @@ static inline void hazptr_release_debug(struct hazptr_ctx *ctx, void *addr) { }
  * hazptr_release - Release the specified hazard pointer
  *
  * @ctx: The hazard-pointer context that was passed to hazptr_acquire().
- * @addr_p: The pointer that is to be hazard-pointer unprotected.
+ * @addr: The address passed to the matching hazptr_acquire().
  *
  * Release the protected hazard pointer recorded in @ctx.
  *
-- 
2.43.0

