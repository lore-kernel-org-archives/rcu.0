Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7B5473C67
	for <rcu@vger.kernel.org>; Mon, 14 Sep 2026 13:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789394021; cv=none; b=CzImo3+5jb2Syzwh5M+1r9O6mYPx0fwWW+7ZUC7pgbUniT+2skNdyTUfWI6ClkTc7bpwwVtNN7txCQ2WiJhzOT+wAkTkVKcQUstCkgJihDg9RxIDgegybatVyUg8XdVzn6gZwa/HbxQHS28pvKSidMuddrLgadfJS4rxeMoc0CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789394021; c=relaxed/simple;
	bh=64NapLqxHH6tJSEV83TdJWZtANu5nmqRrk1E1ae8QJw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aPUdQi5/czcfdcO7zJ2pW1QxNk5UMKzOZj2gyR2zF5Y9Q1moL0Qvgdepe0QL6HC9rQR5Wvw54Ofw37KebMjHYM6Db6AhAIBTgMhNhnbYbLU/yRdtQ1y6oJv0SeTibfVEOh/driwl8qveekBeAYg2mq1zpvcweePR0kz5co0thT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jsLNzZwb; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jsLNzZwb"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3a2015bbfceso23141341fa.1
        for <rcu@vger.kernel.org>; Mon, 14 Sep 2026 06:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1789394016; x=1789998816; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tS09zB4gsK6IH3J6tb9FICxkiH+S9C9kJxAP8cTa3+U=;
        b=jsLNzZwbV1cnyavFdXs/JmbpvPHoVN/XRVbDz39qeT/DJMVvWOI4P1xOsXIWCWeK22
         q0CHVB30PvzPuNIonSd/WDbms0SZfrmhzsO1tON8PT+KvXBNfO5fkKUc9yVj0kYADRrZ
         6cJ7kp4hUkXZKo/CYREJWgh63E0ebbeNzOK2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789394016; x=1789998816;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tS09zB4gsK6IH3J6tb9FICxkiH+S9C9kJxAP8cTa3+U=;
        b=VoSuVGXug2U2BYRVkaOzYnV2qS9As7LJVQmnRQbuTV1UeEyph6C3aRABjXO9qK7+tX
         qxz6EW8nhUjqsaSk/+DyCywKxG/kZvZggVKG0jUpy2xRf5FCZN2ESTuLbCaigBi+51io
         9IAOkQE8NyLxfhXLRRKIQDCaHPXmwCxt9p7Wj3Sx2X/x98jmRJAEzOOmabku0xKWDRvz
         CNsqKhYJFitlI6Df9XK3LHuvKxXAcezHP/sNqWt+M9VeC+a0fsDgNkc0OKxbw954JLIZ
         uc8FeSqH24fNle5DsWpRXHn70wkaklO7h34MtTeY8qZFZ5qpX7RluJqZGeEn5vqRuAOf
         8o7g==
X-Forwarded-Encrypted: i=1; AKwUvBxJZV3WK+JdFCR/f50utGgM0bP3NFlVErh/4r4zHfBniVDNspTY/xvhi5QucW0P88H1fd0=@vger.kernel.org
X-Gm-Message-State: AFuF++kkGNh8ClP7l7WEzyREo+ascn8PMLdx2CRjCwi4gu2PVpFAaIv1
	8vBAoB0KQIZT24zsDm/JKhyR4yrI+0uP8qOFrd31p1pTsGYn4FHdwPz8RC5ZgmhRcg==
X-Gm-Gg: AYBFou3QPvcateW6WdgbVqUAuo8G/uidolLTnhnQboZWaalc8LdeGLBbMZLAyqsTGYY
	G+a3duBh96AVVGZwMSL81rg8vT6xtf4oAivCPATabMm4VFrXwFq1jmq+zV7ReCkdkil8lo7SZ8e
	kfBGx9MhiZdrTz+oTnyzgwHe5nZ8+ZfqXK/hYuBnu5KsZSxAdOQ9tHORz/LWZBYLUh5jzIRMNfi
	gcmj5DDenWUzwzQXBKrU7dDXqk/BJ8IFNQOS1yRqbgUXDwbdmhy107OhloAggAotCr6KTvTFtO2
	xiBcRWXyP5q7mVyxcqNf74qPh8kZbYBYxS+qGodoqwBnZKgymA1GG33ae1wVf1FVbdyBYc/BapE
	0fwQfwkorS3PvHPG3LnaNwE7jzr8IINeCm7Aqi+AIC+QX5t9QWtH6+mb9v0zxmU6MN3i6XaRPIK
	6dQ9Nr/z2cTucQ03yeSXbox2wt2T0VusLRTEcS+XgMlM64AC8FG8/0Zh6PTR/Rx4DMGUnuXJ4V1
	HyQgI2nlw1ujLd35wXqESVzR6FeN5mDMd3OeS0XzPnujO3N1w==
X-Received: by 2002:a05:651c:146f:b0:3a3:61ec:43bc with SMTP id 38308e7fff4ca-3a5be1ea6a3mr8393601fa.13.1789394016399;
        Mon, 14 Sep 2026 06:53:36 -0700 (PDT)
Received: from ribalda.c.googlers.com (11.36.88.34.bc.googleusercontent.com. [34.88.36.11])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a5a3304b38sm29433921fa.13.2026.09.14.06.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 06:53:35 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 14 Sep 2026 13:53:32 +0000
Subject: [PATCH v2 2/2] x86/uaccess: Drop the address space qualifier from
 put_user()
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-unqual-v2-2-60a1407a0cd4@chromium.org>
References: <20260914-unqual-v2-0-60a1407a0cd4@chromium.org>
In-Reply-To: <20260914-unqual-v2-0-60a1407a0cd4@chromium.org>
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
 Chris Li <sparse@chrisli.org>, Dan Carpenter <error27@gmail.com>
Cc: David Laight <david.laight.linux@gmail.com>, rcu@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.14.3

__typeof__() preserves every qualifier, the address space included.

When we do __typeof(*__user *int), we are declaring a __user integer,
which is pretty much meaningless. A value in a register or in the stack
does not live in the user address space.

This annotation did not trigger any error until a recent version of
smatch[1] started caring. And as a result of that now we have tens of
warnings like:

  drivers/media/usb/uvc/uvc_v4l2.c:1112:13: warning: incorrect type in argument 2 (different address spaces)
  drivers/media/usb/uvc/uvc_v4l2.c:1112:13:    expected void const *from
  drivers/media/usb/uvc/uvc_v4l2.c:1112:13:    got unsigned int __user *

Instead of __typeof__() use TYPEOF_UNQUAL(). It maps to
__typeof_unqual__() in recent compilers, so the address space annotation
is gone.

[1] https://github.com/error27/smatch/commit/e53027a4e816a772403baafa83c09e4a94c1cb8f

Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/r/20260825-unqual-v1-2-7024fb81b4f9@chromium.org
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
2.55.0.1007.g17ff1f9808-goog

