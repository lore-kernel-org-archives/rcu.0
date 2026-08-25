Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4BC387378
	for <rcu@vger.kernel.org>; Tue, 25 Aug 2026 20:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787688139; cv=none; b=NJD6D3liUE+4Ph/IwAOV698dpGi0FOKjACZ7RF+5clA3xxu5KZsicXZYHi+0Jh3F2tEVZsgsvhfhFYKXzEVneo+qgN9UPN+SIY3JVdVLQRUfHvkrptoKz9eEGC+wr1U/NZDwp7NT6XSpEQHdKoux/d8NQ8vvw2jdf4yemwGZmYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787688139; c=relaxed/simple;
	bh=qUBA6A9UnyHbYzJFPiZQnoAk4q/iuycPsbOtXqa6CtY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DtiYmwesd2DfeBoBcrKwAkPB559ROiV50IuV2Nm33JnVMW3awSerbdp42oe85lLskK9yzWhnTSOXeu4rR7szXOI7He3DFHVDXfdRCIt5JFVga6z8tHgJotTw67lQhKTUgNL1XNwjELrpPiJlntibwqJBjf3MJZ0vOxoIWpoSZA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZxNFX/Ex; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZxNFX/Ex"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5aec6360133so120255e87.1
        for <rcu@vger.kernel.org>; Tue, 25 Aug 2026 13:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1787688136; x=1788292936; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UX7g0ukijwjjIrziQAgaTHtTRLbta6EIpn4u0/mNSSE=;
        b=ZxNFX/ExHXAUebpdXw902S1auhenzWEpOXYRKpXDRFxK/PnER8g3/q3A1n3iYxE0lJ
         2ZGTRh7QVBDpCsuX7vTjSddmtQi3qXZcOVGitmvXbWUHNlVkLMTMTrEx9ftNZs1RJ3vz
         5bbr8ePrFKqJpOELdOiaKMmQmvpt0+zQ0UE8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787688136; x=1788292936;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UX7g0ukijwjjIrziQAgaTHtTRLbta6EIpn4u0/mNSSE=;
        b=q7VSYzE76jwJognHSOSUuog6n+ovWzabKbix0y8DgEKzv9ah+BbUIpTrRV0QVNbBHX
         L/GsEeR+05IxiSoNb4zememjcuazy6rKOW+eP9QjEmn9DbGKTA20Uo9zZepne1TW5KWn
         +t5Rch3PBgGerMPQlxzD/lBR6Fur08t54OW3E4HV+3mSobtsojV3Kjco/4hnHL6UDElo
         hxAzF03SpYGrCRVFBgUZoAWouhHIDmwlk59wnOoN4vnmQwsK/Z3lsW502VUVmzwtOhsa
         RtROYF2yKWlEEXsz7NOYuEeHP6O5eFmadoKebo4Ub80CPmf+VYWsCc8k5QpQGkddDXaG
         H1QA==
X-Gm-Message-State: AFuF++kOzJg1HonwEiFj2bRcDqaor4eZoPShmar93rSeCsqKXav4jqck
	4sTMG3SMHK/0L3pxGODbcZ9ckYAE5qY3Qy02ozy04QC6Tp4P5WorJDfDLUilNUa9Wg==
X-Gm-Gg: AR+sD13bjpNpQU5Y65UAvLQQom3EQ1bvKVNmdeZNs876PULaM9BIqqSjuoN+KZo38CT
	Yhboq9MUtizMXpykxOvZy4tZ6fW7bb9MR9etdiNWOWBn88fhj2kmZzfcepAmLobRYy4LXdkgi1T
	C5c5PeW7W1X9DphKHMjsF0ypr/Sn5p8Ic6GikAYfEkKHbqhvP8O44PitGwvCz/PW9vWdCYm0JtC
	Zd9Q4r1AwDKjEaiZZD9Hmcepd5GLUPWhpQX2U+eIr4ZpuJ0yxdZmJh7rHP5GTLvdP/+rfdCOG2A
	MPTOJjB8rxU/Z/cPHaA5ph/iq8fyycMUP4Hceaqe9lfG+22Q4kFzT1hR7QzYS608nXUTKDHiUG7
	2piUUg9fkE1qcEG2sTDdBltH1i3MY4TQNcD/2wKRiPv4TNPHGAN20lY8B8V/yW+TT69HT/rNcd3
	5V12zgEREozRfkaPwINpUeu22nZDyc9mJ84AeCyQf9rlAT9ntD3r9eRcTO0FxAB+HiwBLAHBtRy
	F8ooxbAuzzlMAknjKs95DhlDb4sh//n4cjL9DqUK992Cvq5Gg==
X-Received: by 2002:ac2:5e8a:0:b0:5b1:537b:de9b with SMTP id 2adb3069b0e04-5b4a9064b4amr172876e87.19.1787688136158;
        Tue, 25 Aug 2026 13:02:16 -0700 (PDT)
Received: from ribalda.c.googlers.com (11.36.88.34.bc.googleusercontent.com. [34.88.36.11])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b4a41533c5sm135381e87.15.2026.08.25.13.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 13:02:15 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 25 Aug 2026 20:02:10 +0000
Subject: [PATCH 1/2] rcu: Fix casting while dereferencing rcu pointers
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-unqual-v1-1-7024fb81b4f9@chromium.org>
References: <20260825-unqual-v1-0-7024fb81b4f9@chromium.org>
In-Reply-To: <20260825-unqual-v1-0-7024fb81b4f9@chromium.org>
To: "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
 Joel Fernandes <joelagnelf@nvidia.com>, 
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>, 
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Dan Carpenter <error27@gmail.com>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.14.3

Recent versions of smatch preserved the address space qualifiers with
typeof()[1].

This fix has discovered an invalid casting in rcu dereference logic.

This patch fixes tens of smatch errors like the following:
./include/trace/events/vb2.h:46:1: warning: incorrect type in assignment (different address spaces)
./include/trace/events/vb2.h:46:1:    expected struct tracepoint_func *it_func_ptr
./include/trace/events/vb2.h:46:1:    got struct tracepoint_func __rcu *

[1] https://github.com/error27/smatch/commit/e53027a4e816a772403baafa83c09e4a94c1cb8f

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 include/linux/rcupdate.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 44c07a66edff..80276cedda80 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -488,7 +488,7 @@ static __always_inline bool lockdep_assert_rcu_helper(bool c, const struct __ctx
 context_unsafe(								\
 	typeof(*p) *local = (typeof(*p) *__force)(p);			\
 	rcu_check_sparse(p, __rcu);					\
-	((typeof(*p) __force __kernel *)(local))			\
+	((TYPEOF_UNQUAL(*p) __force __kernel *)(local))			\
 )
 /**
  * unrcu_pointer - mark a pointer as not being RCU protected
@@ -503,7 +503,7 @@ context_unsafe(								\
 ({ \
 	typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
 	rcu_check_sparse(p, space); \
-	((typeof(*p) __force __kernel *)(local)); \
+	((TYPEOF_UNQUAL(*p) __force __kernel *)(local)); \
 }) )
 #define __rcu_dereference_check(p, local, c, space) \
 ({ \
@@ -511,19 +511,19 @@ context_unsafe(								\
 	typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
 	RCU_LOCKDEP_WARN(!(c), "suspicious rcu_dereference_check() usage"); \
 	rcu_check_sparse(p, space); \
-	((typeof(*p) __force __kernel *)(local)); \
+	((TYPEOF_UNQUAL(*p) __force __kernel *)(local)); \
 })
 #define __rcu_dereference_protected(p, local, c, space) \
 ({ \
 	RCU_LOCKDEP_WARN(!(c), "suspicious rcu_dereference_protected() usage"); \
 	rcu_check_sparse(p, space); \
-	((typeof(*p) __force __kernel *)(p)); \
+	((TYPEOF_UNQUAL(*p) __force __kernel *)(p)); \
 })
 #define __rcu_dereference_raw(p, local) \
 ({ \
 	/* Dependency order vs. p above. */ \
 	typeof(p) local = READ_ONCE(p); \
-	((typeof(*p) __force __kernel *)(local)); \
+	((TYPEOF_UNQUAL(*p) __force __kernel *)(local)); \
 })
 #define rcu_dereference_raw(p) __rcu_dereference_raw(p, __UNIQUE_ID(rcu))
 

-- 
2.55.0.897.gb25b4bd76c-goog

