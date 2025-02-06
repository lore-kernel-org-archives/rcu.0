Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC7B1DF74E
	for <rcu@vger.kernel.org>; Thu,  6 Feb 2025 18:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738865884; cv=none; b=NgtXd+IN7rjnxCMN4e0RPgbmDuUVo2DITRyCwL0zj1lakF8tSX6Knuoragbxpf9w9C36TplX00pKyXgyOQGsZx6SkMhf/pF/8tjb1t9T/myiv+pcpS176f0bvBgNas+H7Mwb1IR1ffcBlknasycPYdyl8wH7hdn7Tpvndx3+TZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738865884; c=relaxed/simple;
	bh=OUyhDVr77oUg9Ew94dbfOaYtUgHMDOjvOzaZtS/8oZ4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mE135elN9u+dd+6x6RifC50a8qMJRGKBWaTwwjzXwb6c4Sru6MKnEyo+SSCYLItyCUZaw4SBbhdcgVi4feXRajaupRh1DvvnWujrwewF9EPsgu5N4He8My0OsPOKMPDQUQTcU0T1F3+mp9bxQAbYK5Q37bZJr8/RDGlLdc/3zD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XqltBCv/; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XqltBCv/"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4362153dcd6so6975395e9.2
        for <rcu@vger.kernel.org>; Thu, 06 Feb 2025 10:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738865881; x=1739470681; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VsoCl0Fwo1Ic1mnwHNM6zvZdMp3PVmxgZxLwt6H7/D4=;
        b=XqltBCv/PhH36XyvvGL0gKijrfWt6NFZkgWxlBdjL2PWo9C3koQ3faCtpRQrLO8bhf
         TAK1W6eHQkT4MDRKhDPZDBRQtSAF/YdoPIKr2n6KcTktxDWY1Xm14N1iY0ifgNQbSRKI
         FrdkikeWJS1lpbvZAE0/ZctiCnXnkWGJyMttf239oKIh8NlZP2SgTLnc/rLSbmColp9h
         sFwyH4fl6ddo/wBNWBtyXiIP4+Fcv71X4DDBggAWE4uR78TGDSGpI0PkNSC1vpvvv0H+
         s65A+fGSpkfgbnd2/fITFdQEY9/tVlcFyEWLcbik4rM61HX1gWI5NS+TWpiknzfnYz7w
         gFkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738865881; x=1739470681;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VsoCl0Fwo1Ic1mnwHNM6zvZdMp3PVmxgZxLwt6H7/D4=;
        b=ipEykKCn5EWQ1kln8KOegxC+3BDKG+x1+IZ6avQMZg3PXPHncY6pWizt9bKKP0mEKJ
         RPJGNV/Tlu3y0HElrjVfemEbEGUVI7O9oG6b5yMkxNfp87puNX8NroA1GmgNa5Ueglqj
         ZUQPPcoTffZh+VKrx1m00eoaQSEfZ4oiSFEc2wxMPD7acLtsU22GPOkedG/E4CZxzz4z
         /iWROZ4szSF11pHdM8N4Kiq1Xb8gUUzG9nYlwEVOCWcGDrDICW6Htffk1D2WvE7jLL5H
         yvL+mDCCt/GcCAdFdiufL0+yWiHIMgxKIf7pvdXe24rz8Z4iva9xhzYaKOUJA16foTQP
         k4hw==
X-Forwarded-Encrypted: i=1; AJvYcCX9K4IWZe2JGJgnfzIsg4kA1o7NjeWhNiyVcQXTO95keholaiWE2id99JJcQNTLU28uI14=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP8d4+q+/36Uz9zj/SuLJ4kmYzsDNX5Tk9+J4ONtqI/+Y8oNDN
	kT4dNtuSU2nFTnO+wdjZd0vNHiUvWJR3dI8GuAxPzCR2NVX0ED+EputTLZZATGv7hsba9LljCA=
	=
X-Google-Smtp-Source: AGHT+IHiTmn6vfthg2vhJ36+4kRebwXf2RJ94SpIllvtOjA4FgWz+fAElpnxs8wxYNVNWceG+v5BwvdraA==
X-Received: from wmbeq14.prod.google.com ([2002:a05:600c:848e:b0:434:e9e2:2991])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4e15:b0:434:ff9d:a370
 with SMTP id 5b1f17b1804b1-439248c34e9mr5139685e9.0.1738865881193; Thu, 06
 Feb 2025 10:18:01 -0800 (PST)
Date: Thu,  6 Feb 2025 19:10:00 +0100
In-Reply-To: <20250206181711.1902989-1-elver@google.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250206181711.1902989-1-elver@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250206181711.1902989-7-elver@google.com>
Subject: [PATCH RFC 06/24] checkpatch: Warn about capability_unsafe() without comment
From: Marco Elver <elver@google.com>
To: elver@google.com
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Alexander Potapenko <glider@google.com>, 
	Bart Van Assche <bvanassche@acm.org>, Bill Wendling <morbo@google.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@kernel.org>, 
	Jann Horn <jannh@google.com>, Joel Fernandes <joel@joelfernandes.org>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Triplett <josh@joshtriplett.org>, 
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Uladzislau Rezki <urezki@gmail.com>, Waiman Long <longman@redhat.com>, 
	Will Deacon <will@kernel.org>, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, rcu@vger.kernel.org, linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Warn about applications of capability_unsafe() without a comment, to
encourage documenting the reasoning behind why it was deemed safe.

Signed-off-by: Marco Elver <elver@google.com>
---
 scripts/checkpatch.pl | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 7b28ad331742..c28efdb1d404 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6693,6 +6693,14 @@ sub process {
 			}
 		}
 
+# check for capability_unsafe without a comment.
+		if ($line =~ /\bcapability_unsafe\b/) {
+			if (!ctx_has_comment($first_line, $linenr)) {
+				WARN("CAPABILITY_UNSAFE",
+				     "capability_unsafe without comment\n" . $herecurr);
+			}
+		}
+
 # check of hardware specific defines
 		if ($line =~ m@^.\s*\#\s*if.*\b(__i386__|__powerpc64__|__sun__|__s390x__)\b@ && $realfile !~ m@include/asm-@) {
 			CHK("ARCH_DEFINES",
-- 
2.48.1.502.g6dc24dfdaf-goog

