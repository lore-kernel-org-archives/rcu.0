Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242F41864C
	for <rcu@vger.kernel.org>; Mon, 13 May 2024 16:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715618947; cv=none; b=f3yUzJLAx9t6ozO5gdu4uIoSmjNDnid6NdiMDe1RwYc52CgFeTnpSK6QvGNbKWyHSkK4yMow93qlEzKXLtZoyllRJL9enSHX15LVeam0YIsBCnQ8ihnR6uJxZxEV0hB41f0gi37EhD0DH3Bh8j58VyvQZWftMw1yUC5yG+1XMKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715618947; c=relaxed/simple;
	bh=7HJki1UM4r909Ntbce/v15mbZXUH12ohnP4FbyjkcBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JPNN1NFtUfJaKP71uRhOUikmYKdLoY3HnuPfq5x/uMO8UxQB3EXAXqpS+LLGxy++hoSiAb71bSnOV+3XkMgBtnJhOJVeOXLQEzyHt2hIym7c3OZx32eD8Kz5z3RiPhAvJsDoaQw3OpwwvMXXi776QXh4vsdMYw34LjBqEhtTCgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=duc1XWL7; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="duc1XWL7"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2e564cad1f6so32931541fa.1
        for <rcu@vger.kernel.org>; Mon, 13 May 2024 09:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715618944; x=1716223744; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HwX85Cc4Z5UBCMlHC2NISB9r0JBio+whHTW3qGBLXLU=;
        b=duc1XWL7nX6jUyF9XeTKnq3aSxHrGNvjwV8RzjHP6y9YML0Vu1zE2HueMnTED5I/CD
         sUDO355fSVn5qwqvNJ0DU+YFj8YWNbMJe6/UX0Rz58HGoYZ0VZkMbc03CTuxUAhp40N0
         M6gVp+oKvOLBt0hDK7VB27grBclWXLMimb48w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715618944; x=1716223744;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HwX85Cc4Z5UBCMlHC2NISB9r0JBio+whHTW3qGBLXLU=;
        b=vSFCp3MjAWw0X72EfnFIVIhMRAcOw18EeDSgXQOvyqw0Iwrkw3WIhZ3lbZAopvXiBY
         CniSWUCRYDfEz3+gTtFEup52oyfAavt+Om3KpL1N02lxqfdPx1EwyphDIP9eWUPYhxFy
         GMsPQ4CztjBfO6aUDea2+Aic3Ysk4roZLnqp9zJa/grtn/VT/hTQ0/ykvyIhvbCuwHOD
         RAVB+4E7JsGzADgZCeUhaWYTREj+lmcnkBZd7NjGYikkGFd7WcYohO1ZXt1auM1ataw8
         G1A5O4gwrUwu+zP+q8j2x33NNVpMK+96hb6Mjy2Yk4ZzukSkqEKTcDNgKBwGdd0PagF+
         /ydg==
X-Forwarded-Encrypted: i=1; AJvYcCWLtxhoGEK86ZWYcIu4F8XF/hiBNqmwRISeT4ekammCnpAMXvj1wCRYENoX80lIfET8zlq8q6lTINK3GclrMO4yhO9r
X-Gm-Message-State: AOJu0Yzy0degXe+AkdzXPHBSZH1FCrCCMB3QMRCyI/9tcI6vq73h+YE5
	j51o3fqZNToLyFdTt8g6XRYdWQaH0RyfsDg2DOeFKT4TGfOwUSN0fIW5F7hSUB4AgZg0101qMuq
	PpnQhUA==
X-Google-Smtp-Source: AGHT+IFItlOdqjQcwd1NyU3r4rRXPcYg5h1AEaYTQJlAKxwFDg1mIceKkQr9ycVSfbzNwx10dqAHPg==
X-Received: by 2002:a2e:a58b:0:b0:2e2:891d:5f62 with SMTP id 38308e7fff4ca-2e51ff6692amr73754911fa.29.1715618944234;
        Mon, 13 May 2024 09:49:04 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e4d0eed7d4sm15291111fa.57.2024.05.13.09.49.03
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 09:49:03 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51aa6a8e49aso6272593e87.3
        for <rcu@vger.kernel.org>; Mon, 13 May 2024 09:49:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWd8SI0CMqdB9rHmTuHxmOCQln4JDfWHGpqhmLLvXV9JaOq2qXplScBFEeJ27agEwoSPI5/TlqKS37PpfldvaoiTMmU
X-Received: by 2002:ac2:4253:0:b0:51d:55a7:668d with SMTP id
 2adb3069b0e04-5220fb72dbamr6347700e87.25.1715618943247; Mon, 13 May 2024
 09:49:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510183049.312477-1-urezki@gmail.com> <CAHk-=wh=HgEeyKVKGXTKiLdhvs-5t9pFxUkK6ED+zsby=quBdA@mail.gmail.com>
 <e35bf672-88d9-4a00-8237-99298392e55f@paulmck-laptop>
In-Reply-To: <e35bf672-88d9-4a00-8237-99298392e55f@paulmck-laptop>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 13 May 2024 09:48:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjLr_c_7N0rTOD2eBd=WFydas-Z+_9ucwO_YkegYxrw+Q@mail.gmail.com>
Message-ID: <CAHk-=wjLr_c_7N0rTOD2eBd=WFydas-Z+_9ucwO_YkegYxrw+Q@mail.gmail.com>
Subject: Re: [GIT PULL] RCU changes for v6.10
To: paulmck@kernel.org
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, RCU <rcu@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Johannes Berg <johannes.berg@intel.com>, 
	Nikita Kiryushin <kiryushin@ancud.ru>, linke li <lilinke99@qq.com>, 
	Zqiang <qiang.zhang1211@gmail.com>, Zenghui Yu <zenghui.yu@linux.dev>, 
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 13 May 2024 at 09:46, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> Yes, this is intentional, nothing odd is going on, and Uladzislau's pull
> request is legitimate.

If this is more than a one-time thing, maybe Uladzislau should be in
the MAINTAINERS entry too?

              Linus
