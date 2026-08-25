Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298B63B2D00
	for <rcu@vger.kernel.org>; Tue, 25 Aug 2026 20:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787688140; cv=none; b=Gbnmm7O1uspTp1WAs/OFhD87MIAnsXRtK2SkXZMMQPfnKgUkkGY6/AWT40YJnNYGRYfXDdJ0dKfzbFlCkoG0t1Jhnq0Gn2YKXlCc33Mm3hqregrcsrP6PaXTxZNGrdS03LdEI4SY7mJLLe4Y8EMw8OxpSLitgdrP2SunKQp+d5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787688140; c=relaxed/simple;
	bh=I4fpEQQE9zFc0xnAO9CBIB2LJQb63RqiIeKZFmwOlzw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C4g1Jn7bNkUv+Qffql6h12zwjKPc5288ssTBpq39d17xmLT98GtDO6s7Mwx1TlBZeWehqAAdPvny7F/Hu6Sl4INEDv5PANvsQDVtUgAzMgfqw6nvV9bzUlOffdABMgOjmrJWKC48GOxBpHoKV3VVtHHxVGv9R6zYCF05/uqNluc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ClfAUPwa; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ClfAUPwa"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5b01cb18515so136746e87.2
        for <rcu@vger.kernel.org>; Tue, 25 Aug 2026 13:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1787688137; x=1788292937; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GTVqDctRrMjBLA2E0tBTgvop5gHmOnA0BG3Qw1HtV1U=;
        b=ClfAUPwaqsMFUkAZpT875RLTyqz/pDVtGDKsrOIUiAYuoUmvIzLkAJ1g2Pd2uNoTFq
         M8cy4xgalegUZgqsBKElZjPZGb9gviFMYEkUeJVtUFJ4aCvBHfWAJh6jc982/iwLZ0zG
         S5ZFJvDZs8QiB1gNGugLCrtGrOoJaI3cxH/vU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787688137; x=1788292937;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GTVqDctRrMjBLA2E0tBTgvop5gHmOnA0BG3Qw1HtV1U=;
        b=rki1EOdoS/sCQmGqnbyi9lyg+pY1mXfwB4kxEqJhoq7bhLvOITqZedyX54ZmOFGSs/
         8iDJD0gJ8gkImUTBqZpbrWmbcfSBmjBo0npz+nbuldWOOUsQoggvB0GuuDoZUIQRS53/
         4deXHQzge0MeOcCiatxkEcuplJYiMPDRqBID3EnCtbWknbL36Unbr14uzsKMyhCU/kBe
         Dz7i4jTf9I8HpZvv6dpV+rPHUOFBShJsAkmA3bDGHtpBaXnr4WWhr7jOyK9ETok7Jwfj
         NmvgAiACfX2aUx9wrJaaxnLzF7OXRcRsULfP78o7aKFemqnQvkdBRgmd7q/Ku8P4bZtH
         Jn4w==
X-Gm-Message-State: AFuF++klwj9IbVBMpDKDCnt3EKop89T6CIzlJ9+/Jes+lS8FqnVg4YJR
	tXt9emCPryD3rriS+1MCcAomCOojsAWXPQUp2wemI6UInnRBJxyxGDQmR03OuDnCbw==
X-Gm-Gg: AR+sD1239NIDuiilZGsJ6+66TId1FGUU1uG0CGveKxU6k98zqG5hgHf4KP1JiPWHpns
	fBezv6tzDoU6PFejSlansuw1z9l2ro+zwB979JC0FC/w9TGRVxb49tYqt5L7bzCD+eO8EbkPzDd
	mVCNSEWg/iA/mh1SPvHGLfsAXmDE2cAHV2laMr6IiXbBM0FgJ6slTZsdBTn+6gWvzKYJINxIFiN
	h6+ORTiUBbiOL6AdMxYkJPip3U/hj9XOQpi7OLwlOT7UR+NiKrCcA/G5+WexndEywl4TlQf7DqK
	bMGfebj+3JLhhV3RlSaLcrVnJPTT+FXFMZAsbAANnNGiQuGl2R90wbnKfhSfihip+zveQtqb5Nq
	yIRlApx/U4N4NJdUJrnX4YLexw434m5BafsQ1ge5zY/yjNnx9agDqE0HFnO8xQJKhlshor2mC5z
	86p7+SfzUUlfqlY3rpuFn1r7939kyLZCSMZfqvyG9yj1mwsx6sC2jpVbB3rTroplySkZ1IaOyq1
	VEe07BMc/nMLNW2YuVloO0zlpMG9GHRGY6bpqY=
X-Received: by 2002:a05:6512:6399:20b0:5ae:b8f8:77ce with SMTP id 2adb3069b0e04-5b4a906a95emr148221e87.23.1787688137080;
        Tue, 25 Aug 2026 13:02:17 -0700 (PDT)
Received: from ribalda.c.googlers.com (11.36.88.34.bc.googleusercontent.com. [34.88.36.11])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b4a41533c5sm135381e87.15.2026.08.25.13.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 13:02:16 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 25 Aug 2026 20:02:11 +0000
Subject: [PATCH 2/2] x86/uaccess: Fix casting in put_user
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-unqual-v1-2-7024fb81b4f9@chromium.org>
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
 Ricardo Ribalda <ribalda@chromium.org>, Dan Carpenter <error27@gmail.com>
X-Mailer: b4 0.14.3

Recent versions of smatch preserved the address space qualifiers with
typeof()[1].

This fix has discovered an invalid casting in put_user.

This patch fixes tens of smatch errors like the following:
drivers/media/usb/uvc/uvc_v4l2.c:1112:13: warning: incorrect type in argument 2 (different address spaces)
drivers/media/usb/uvc/uvc_v4l2.c:1112:13:    expected void const *from
drivers/media/usb/uvc/uvc_v4l2.c:1112:13:    got unsigned int __user *

[1] https://github.com/error27/smatch/commit/e53027a4e816a772403baafa83c09e4a94c1cb8f

Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 arch/x86/include/asm/uaccess.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 3a0dd3c2b233..4e576c0b9131 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -172,7 +172,7 @@ extern void __put_user_nocheck_8(void);
 	int __ret_pu;							\
 	void __user *__ptr_pu;						\
 	register __typeof__(*(ptr)) __val_pu asm("%"_ASM_AX);		\
-	__typeof__(*(ptr)) __x = (x); /* eval x once */			\
+	TYPEOF_UNQUAL(*(ptr)) __x = (x); /* eval x once */		\
 	__typeof__(ptr) __ptr = (ptr); /* eval ptr once */		\
 	__chk_user_ptr(__ptr);						\
 	__ptr_pu = __ptr;						\
@@ -231,7 +231,7 @@ extern void __put_user_nocheck_8(void);
 
 #define __put_user_size(x, ptr, size, label)				\
 do {									\
-	__typeof__(*(ptr)) __x = (x); /* eval x once */			\
+	TYPEOF_UNQUAL(*(ptr)) __x = (x); /* eval x once */		\
 	__typeof__(ptr) __ptr = (ptr); /* eval ptr once */		\
 	__chk_user_ptr(__ptr);						\
 	switch (size) {							\

-- 
2.55.0.897.gb25b4bd76c-goog

