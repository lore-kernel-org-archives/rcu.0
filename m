Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2241A6FBF
	for <rcu@vger.kernel.org>; Thu, 15 Aug 2024 01:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723684331; cv=none; b=YN5pKyTP2MicWL3XSOPD8kjs0lrqNPWJuaG2xBfNaNUYhT4FSjaP3T4Jxh0Lq3aKsXPS4kv0ttN3HOwSszar2PZopT1H21ta6BF1Jkd8BAJd1XV+0PVuvhzJYWdq5bRAkvbwdcv3COn04IlDVov3QLyYUJoRKE6HmaPZy2l66IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723684331; c=relaxed/simple;
	bh=tRGOFSacEhAkvZPBHrVgbNQwvq9WfWrFJL+NaeQKOWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U5pXW4H9D62YwycMEnD6YYquCLleJFq5I1SoRR6fFVxGJSCzVGwFpboFBwwadHYfIX4VxK9u2iOeJYKvazV+P2aOVGFohLpbVnDWbWddF5j2dbuhE7F8YqraSZaOM9kyOMrGT8KPs3Hx+g6SrtE/J9mOD0Fl4d070dZYz2npccQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AChLl51E; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AChLl51E"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5a1c49632deso629811a12.2
        for <rcu@vger.kernel.org>; Wed, 14 Aug 2024 18:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1723684327; x=1724289127; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PtB9i2vx1b6x1TFpSuolWbUF8gIZY9vJG3uls6mv9c8=;
        b=AChLl51EUPe42Fx+f0a50Im7vH+2mxTLYnCvwdZ2ayJRcNuTbNPWGTAunhz+MjvJAQ
         3fHivb+JmkHIGs7qW0+1RNNhTOU3stEMtg2Qgc7JMPiO4PcuW6zp8zIQw+e2Pk7s9JcM
         dLnS5J8Ir0aVLDflcBhFk3UlRgCqbPz6h/zTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723684327; x=1724289127;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PtB9i2vx1b6x1TFpSuolWbUF8gIZY9vJG3uls6mv9c8=;
        b=Q/bGtww5SBMGnronLiNPdL4apmo4vH6NGNvUz6aiEA5l3pQ2582k613JF1jXcITkSO
         +Sl7MBPoFhG5qyVIjsW8C57PN9CVArP+E8e7y8CkayAo3ayohVZLtRcSZ7u9wsqAcMFI
         u+JdiFPqtrfNHWGUb0r5jnTsvKJq62bAkjhTfoI1ApzglFOWJNgw5OlhT9tRpXCJlS1k
         G86h85hI9DKvpL+6M1Strzst+Hiaj08aJh7jk1XXh5qUFIMrwI6v+m0lfCzlDiCJO4gf
         +UG1kj9mBXdmuewyY8elDHTH9edUjeUWbZn6zXPkkho0pfXYBMMhNtlxju6kEGmiwZAG
         BDsw==
X-Forwarded-Encrypted: i=1; AJvYcCVDwTGfMkt/SjoPYCwPGkv8j+wXPNuXPs43bpDlw0jkgGhiWLlMzmgfngKHoLt8tkwZRRAlT58on8qajq9Hg66m6Oxj
X-Gm-Message-State: AOJu0Yy7uggRfoNQ4ykTYfq0wFPAwYBVWOZ8T+rgUpO/bikNpplS4rLZ
	41ojmPgCP2k04oTyewWpgA2qjTFJgOMQe88O5ZUwGSPJvJnd78xclJD08epbVR0JXgPzhWCHDJS
	5Ug4=
X-Google-Smtp-Source: AGHT+IHBi3DUgDu83dcUaUQ4MfYJgl/Tfy40CYgs/sOtIX7ebionrD1/36ONxVLJklo/SjKuZgQlHQ==
X-Received: by 2002:a05:6402:84c:b0:5a2:abcb:c4cf with SMTP id 4fb4d7f45d1cf-5bea1c7f2c7mr2618960a12.22.1723684327088;
        Wed, 14 Aug 2024 18:12:07 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbdfb7aasm226102a12.51.2024.08.14.18.12.05
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 18:12:06 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5bb85e90ad5so505066a12.3
        for <rcu@vger.kernel.org>; Wed, 14 Aug 2024 18:12:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVw90GsRUVgrA/hQ7CBQ65cC/vmDBG/sU9qz3zHstEg7D1X3uE7RwyN4zbkgbZfzvZ7LYgAvSEHnU5Pt6OTULZ0aN2r
X-Received: by 2002:a17:907:e2a3:b0:a7a:9ca6:531 with SMTP id
 a640c23a62f3a-a8366c1f6cbmr306904366b.4.1723684325260; Wed, 14 Aug 2024
 18:12:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <08c365a6-e382-4a0c-b1c6-89e57b87f6de@paulmck-laptop>
In-Reply-To: <08c365a6-e382-4a0c-b1c6-89e57b87f6de@paulmck-laptop>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 14 Aug 2024 18:11:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg18amRv=vszzVZMo8L1C-jEExCQaVbjOCTDYFq_L1KOA@mail.gmail.com>
Message-ID: <CAHk-=wg18amRv=vszzVZMo8L1C-jEExCQaVbjOCTDYFq_L1KOA@mail.gmail.com>
Subject: Re: Neeraj Upadhyay will do v6.12 RCU pull request, Frederic
 Weisbecker v6.13
To: paulmck@kernel.org
Cc: neeraj.iitr10@gmail.com, frederic@kernel.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Aug 2024 at 09:32, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> Just to let you know that Neeraj Upadhyay will be sending you the RCU
> pull request for the v6.12 merge window.
>
> Frederic Weisbecker will be doing this for the v6.13 merge window.

Ack.

> Please let us know if you have any questions or concerns.

My goldfish-like memory *may* just barely remember this during the
6.12 merge window, but by the 6.13 one I will have completely
forgotten.

That said, I use my email an extended memory bank, so when I get a
pull request and wonder "was I ever informed about this", I'll
_priobably_ just search my mailbox before I start making a fool of
myself publicly by admitting that I'd completely forgotten that you
told me the plan.

But if I *do* end up wondering aloud, just roll your eyes and point at
this email, ok?

            Linus
