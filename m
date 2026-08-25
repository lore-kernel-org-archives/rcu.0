Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456483806D2
	for <rcu@vger.kernel.org>; Tue, 25 Aug 2026 20:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787688138; cv=none; b=XxOla6lL+arZ5uoV0inuhW6vpyjpK39eUVnUpwfIm99inYBPe17TSlpWk8qvqw4YrmJKv9SzwW9Gxypo19WLP8XV4gOAw9EVeam53F+LzReGIZwFi8VvnvmOVYKfsX6De01AupqEZreqa4uu5Ro4lGgFEvuyY8puv8NZASRHEWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787688138; c=relaxed/simple;
	bh=O7y3IluJMK/6pA1hlZoHNlPX/Gm62xZ0jklwqyiwC7Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qlF6YBgtJIUTPanHbpMZVxmX8n0qgwZPYFN981kF/53Xo4XeMbU9dLJsx2vkZe8htOePIXOy64HDiPDwMEMrS7dtQvNy3sLzcZGzH7xV9pWu3nPYEvsAss/oCukXEMlkV7z2wYXuW+kzHNBLWJETbHjydXEmnkbykBeDGJ4vIzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EvwA35cQ; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EvwA35cQ"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5aeb2bc82ccso141324e87.2
        for <rcu@vger.kernel.org>; Tue, 25 Aug 2026 13:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1787688135; x=1788292935; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DLElBAQ3asF/fSjoLEYXQNanm1yfS++Q98wWygCv/i4=;
        b=EvwA35cQMnuc74UswhXnbdzRItqvZFgZy195bb8/FUwi6F1KYCPGY1DBMrTaBJugHG
         HdwouHZoVW1cxuSl2KK1ryONr+svdeB+qcrIV96nh6X9KErF4HyAAtFDFkWbC3Ev5i3d
         mJ0LiuoZuYRtdC0OAl5WtnBPWqEgjSw9T2VEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787688135; x=1788292935;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DLElBAQ3asF/fSjoLEYXQNanm1yfS++Q98wWygCv/i4=;
        b=e/Qehk7aHIc1/aWQkP6Fp18t8T3fsElQbFkCf7hdeWUSJdOcd1sIhQL2M4TE1fRA7W
         jdp3IsQgRagahp34vMH0lNxyxm7j+IBy/uOoRbRmhHNJxnzCdNk/Q1MA9qs3g7DBbtVj
         lO1zapqE0USbaurOsTpq/1ysZaH6V6opMAhRwlDHH2qc4IcD7n9GukbnmGbXAhzuw21l
         ynp86EdSZuQhGY7rTcEDX1w9KVp0HluxdDlO7Y7KtUPsekkzOagdzhdzKwmXfUEv+xPt
         tq8XgZGbMXOiFV0vnwnoDnQseKQCO51Uc7JwM7Aotbag9JprTbBmdRw5sVoK2KA8yH70
         yVWA==
X-Gm-Message-State: AFuF++nBkMdYWHJTBfkePDKg3oghB1rdFP6QVDjTyIxJRJopEJrM1nv0
	wccrPbdcdMsUYIc7TrrHdd71SYYrIqktyWoFiAjeQr4HFoDeJarlW7NaiTONROINvg==
X-Gm-Gg: AR+sD10pr9q/oWn9MPMWkc7rOpNgMQv5naO7XYLnzfTThPPn2G1eVm4zceyu5aCAmR+
	yEB45sbbJpKGz9bR2CbWdTBm3HfNF4ILJSZvIyItc0WcG8AetiixHae5FFASnWfUZ8iwrP5Xw3n
	eprfT8+zScTwaLh0WuvqoGg/e1+Hn0dpp/7EyCWAoSvxuhjwZwVisQoK+qB0sahXmDUkdLy+P9U
	cv/E8Bqw/pUIax+QlBETsj0Yxs7j2P+TUw1MtYtKboTJo4VCHe4kgecEZQrnhWX+Ox75YbofHZB
	/GDOXJuI+a5NbTK9kpK8nLk1E54gH8/fMfRAzdBjG0jLepdQMbnItGPzFvAP5JSnKbEWufuvT/K
	rK3eOTcjYjdt1DOJuYvRpw5/ooGwWPMnVNclm2Ry73jAdtG6vhP1/khr7gxgrAGMIYEYa/OXgyN
	Ozq7nXvTfb+i5wCcBWaJAAvQIn4ZlCUBpxthsaHqsZcaAsrygQ1JDArCUjELESdIBmEfs69VofA
	YsbLZ3flDljzPSxlxc1xfcXrQXof/BVU+9kYnk=
X-Received: by 2002:a05:6512:3c8e:b0:5ae:b7bc:27a7 with SMTP id 2adb3069b0e04-5b4a901432dmr167451e87.6.1787688135140;
        Tue, 25 Aug 2026 13:02:15 -0700 (PDT)
Received: from ribalda.c.googlers.com (11.36.88.34.bc.googleusercontent.com. [34.88.36.11])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b4a41533c5sm135381e87.15.2026.08.25.13.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 13:02:14 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH 0/2] Fix warnings with recent smatch
Date: Tue, 25 Aug 2026 20:02:09 +0000
Message-Id: <20260825-unqual-v1-0-7024fb81b4f9@chromium.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMH0jWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDCyNT3dK8wtLEHF0j0xTL1FRzk7QUQwMloOKCotS0zAqwQdGxtbUAjZ4
 wtlgAAAA=
X-Change-ID: 20260825-unqual-25d9ee74fd10
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
 Ricardo Ribalda <ribalda@chromium.org>, Dan Carpenter <error27@gmail.com>
X-Mailer: b4 0.14.3

Recent versions of smatch are more exhaustive while running typeof() [1].
This has triggered new errors in media-ci.

This series takes care of them following Dan's suggestion [2].

[1] https://github.com/error27/smatch/commit/e53027a4e816a772403baafa83c09e4a94c1cb8f
[2] https://lore.kernel.org/all/CANiDSCuizbMt77XfrzGPMa3Biai5TF1vcs+C5qdhYoLrP=9b3g@mail.gmail.com/

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Ricardo Ribalda (2):
      rcu: Fix casting while dereferencing rcu pointers
      x86/uaccess: Fix casting in put_user

 arch/x86/include/asm/uaccess.h |  4 ++--
 include/linux/rcupdate.h       | 10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)
---
base-commit: 66498c75b4f8017f62d720d9b59675bdf3abce91
change-id: 20260825-unqual-25d9ee74fd10

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>

