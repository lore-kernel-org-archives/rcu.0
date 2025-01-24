Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A5E1ADC6D;
	Fri, 24 Jan 2025 16:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737737841; cv=none; b=qTLXP3okWC+TiDwl2YhXJM28b+sbSWlYY6YB2L8uIdQF2oNSPGQQ4dCORtQtKiJ4vbAHPLi6W2ys49BNpX+Q9a4fbZHz5BPXY012FcTm93whMDQaBm130gtTk3m2MpO+WdqOWa79EFedmZ7mNmf+HOLtOdVOD90vUpkwSQGHOIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737737841; c=relaxed/simple;
	bh=f5BdNfLG7qVGb77pe5MWvPmr5N55juXmpHxg9JmLi8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wfd6i3NATLdZEeask41bh9YClOL2sP+thWn0GKA7gOJIt6KIKQuXAM+zFNAmz0qt++xMkN+E0RqG2UX7/p08GISAAZmLQvzww6/0mBe8sKd7IE5JpxDINsm9XlSiz7GRGFr4RugMaTmk2Rj+gqb5VQc+pf698Q2ZZxJxcYQu9KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GauZP0/N; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GauZP0/N"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ab2bb0822a4so467483466b.3;
        Fri, 24 Jan 2025 08:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737737838; x=1738342638; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T4bXFjNsYpYRfvfAbK17JWFokNDCLw4ZHyHFhst1k2k=;
        b=GauZP0/NeqAkK19rljCWi+xWrlpvMBcMofRkikLb/qsEvWm39f1sb/U9ILUTUQtc+7
         lEUxdo7CsuJiaxi1KNvEm04f+YpxfoI0GpH8ho6yN5dH77K72y3a2TTgZvr5yS3m4AW2
         6yREqF33iv2qAcCJI+OzrWHdIho2BBEKj0bKiie823lG493Gm5fNjKKkw3+fEilHXGmf
         EcrwoMRqkD3QDsroErR6xazKILc2YAA7QVoxLiwScbMEIR5vBLuUp3upXH1SvYDvj0Hv
         a3cMDiWd80ID5wbGh1jVZ4in5w+MhwvF14Ql/ZJx9lHI/7aC0NpE2nljrMWbHdPssFXo
         ookA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737737838; x=1738342638;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T4bXFjNsYpYRfvfAbK17JWFokNDCLw4ZHyHFhst1k2k=;
        b=wwtnr26wSd8ifPRGPns/Q5ZApmEQjve19/7xl1glLvCEnmtLdM4QRtBj1+ivjMHUrl
         W0h7ul3h+VCZ8wGqZ3LNM01F3iEeqP6miHDhDLQyi48qyzV9Xu+CdngSQwbF2FLhcif5
         ttxboKFfxzh9Hvob5lXEt+KeSKF8IGF4YxAJsBEa487Y8I+1Zp05QvGSjf5syca3CPQU
         fPuo1SDZjz2nQclWRzyZcOzqmBkD4ATNbdaalEIMFeUU0jzMZyoc1UibYycDGgEkj1QL
         uRgf/DHRumW7/yDwb0ZhvFh6ULcX+aiAtVlYBORaAPyvOukSC+9UKln0nq29j2IR+XAC
         Sx5A==
X-Forwarded-Encrypted: i=1; AJvYcCV9b6SH5/s9eAn5cBJ+8pqLXcZ8NvptyggOWQR/ra7ZBEKuTZQJpHRQKXxtmQAiM25FmAMr@vger.kernel.org, AJvYcCXpEEBMhW/otCfInL2XJJwqoGZDnOVUgj0qzBD6kyrsR4ZonkuVjsHYUOKK7HNaitytU4jQLwNGOADkJA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4Zp4Xjvtl98RC0NIOnpvm6UHN5rcz3fvraoXNabheaB66K0wn
	dGbhNORlu7RcqpmWMOFpe1byj5uIckVPhaEdA4e5eye9v6ij9NYhN1dcYFCNE0gTHCh9k18BkVr
	/Xa1rce/7lOkn8h3SXTRpmJHBfXY=
X-Gm-Gg: ASbGnctqzmQjxFVF+XxicFG59B7m6eZSxJ69I/E/M6BRG3jcC3sbjqy5Z9wUqhbW45J
	7x4jTEtWl2TOXczteOXzCvbwsPsF975ZXqnyLBxViCRtvgASW4ouS2OXgd5Ueo9o=
X-Google-Smtp-Source: AGHT+IFiqJ9dADUH7qn1R/PXwAau7xMCFJ5HMHkvmVmV1fDdRpT+sa9PcOwGsYYLD0s3dVENdSrgiOxP1uEpW3m+H04=
X-Received: by 2002:a17:907:7296:b0:ab3:4c32:aa6c with SMTP id
 a640c23a62f3a-ab38b10cfa4mr2992452466b.20.1737737837384; Fri, 24 Jan 2025
 08:57:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+=Fv5SW-N+5KzsnVdHvy406-p+g7giUbt626xwDduy6xjaPkw@mail.gmail.com>
 <CA+=Fv5TtOQkDMPnuPrPGcB0VGhUHUDqe5=Z+ovd5x5rBJ-Hsjw@mail.gmail.com>
 <alpine.DEB.2.21.2501122348510.18889@angie.orcam.me.uk> <CA+=Fv5Q9UxeSP0U10d281Nbm3agyFgpwyY95+d2pAWVWJP=2Yg@mail.gmail.com>
 <CA+=Fv5RU946-r5S8hZKTF4w20s82Oc-JDe-pCa1W7zjr6nEoag@mail.gmail.com>
 <CA+=Fv5RntE=Z=PgYYxBDLTDES6aWkg-+yqEPPDjv-E7GCcoufg@mail.gmail.com>
 <alpine.DEB.2.21.2501201317060.27432@angie.orcam.me.uk> <Z4-jgMJgbVriLaCr@minute>
 <Z5KMHoA7GlHJyUU_@minute> <alpine.DEB.2.21.2501232306270.27203@angie.orcam.me.uk>
 <Z5NxuIFsMUvqWUtC@minute>
In-Reply-To: <Z5NxuIFsMUvqWUtC@minute>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Fri, 24 Jan 2025 17:57:05 +0100
X-Gm-Features: AWEUYZlaK5IQfun0t2CnwCwXSR8Gm3WPQ0EhK3IrbGrA1i4BSMz2uDtOVcSlfWg
Message-ID: <CA+=Fv5QmSkP4Ysp1zHNmUPftXYbSquTCsO_o3Rcgi2T5RcPj5A@mail.gmail.com>
Subject: Re: Kernel Oops on alpha with kernel version >=6.9.x
To: Ivan Kokshaysky <ink@unseen.parts>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Michael Cree <mcree@orcon.net.nz>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, rcu@vger.kernel.org, 
	linux-alpha@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Are there other parts of the code that might unalign the stack, even
if the stack is properly aligned to begin with? i.e passing an uneven
number of function arguments on the stack or inside interrupt
handlers? Alpha does not make use of a separate interrupt stack,
right?


On stack alignment in "ALPHA Calling Standard":
D.3.1 Stack Alignment

"This standard requires that stacks be octaword aligned at the time a
new procedure is invoked. During the body of a procedure, however,
there is no requirement to keep this level of alignment (even though
it may be beneficial). This implies that any asynchronous interrupt
handlers must properly align the stack before any standard calls are
made."



For now I've reverted the stack alignment patch and I'm now just
applying this patch. Now the ES40 is stable again

--- smp.orig 2025-01-24 17:50:18.822326213 +0100
+++ smp.h 2025-01-24 17:51:13.772835769 +0100
@@ -30,8 +30,7 @@
  (struct __call_single_data){ .func = (_func), .info = (_info), }

 /* Use __aligned() to avoid to use 2 cache lines for 1 csd */
-typedef struct __call_single_data call_single_data_t
- __aligned(sizeof(struct __call_single_data));
+typedef struct __call_single_data call_single_data_t;

 #define INIT_CSD(_csd, _func, _info) \
 do { \

/Magnus
