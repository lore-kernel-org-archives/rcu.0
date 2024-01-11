Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD6A5476B
	for <rcu@vger.kernel.org>; Thu, 11 Jan 2024 19:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZSPDovLO"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a27cd5850d6so614728566b.1
        for <rcu@vger.kernel.org>; Thu, 11 Jan 2024 11:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705000356; x=1705605156; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4QzH687SLZ0DeiH1lFH9rSO+vnMHWQfHO7cGTEaKRVY=;
        b=ZSPDovLOBMpX6NjsCFqH6uTY85WgKgVvsEYaEsk3w1y8Kswk+1D20MqoymXmBNKJ6T
         XL2ylqeVOSCBvuYQWu46MLSjOCCxdgKv/uSRy/KhJU9dgYecED5FDE41DH+mEVfyb96E
         3jXm97drxgYYNX6Hz84le8/DMpT5a0RUctrsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705000356; x=1705605156;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4QzH687SLZ0DeiH1lFH9rSO+vnMHWQfHO7cGTEaKRVY=;
        b=Yn5KSQ7Dbk2wravccgJy0Qa5ADs/1q0/sLttSE8SOVGA+MeMmW+OX9mS5nHHSOaUc2
         H3bX20jeafhkQ1S1HhqN93LAbngbJpln+aeaWu29GVFHPsN05nkd58DiuHbJcNRhSx2P
         /b0o9stE92FJk9uKbsHwPW4/soH0o9u0L/QjG1CIZpfILjmDQCnNStlMPFCobXp8LMri
         BeTs+VIFp3Do9s5me67NQ645g1OX9nYuihxaBHgwLCdIgpJPe2wbVnvc0UKfjSYLjR0/
         1GzP1ST0KoMZmrLafagwQNSwBOqv8gEGMz/9rctB9E5InLOSBZN3OAeL4dCt/pBJSJvD
         nIsg==
X-Gm-Message-State: AOJu0Yy3gzIPT3wgOCjk2E63+yst9JI57Pexi2VwJQPoqZ+ZfyCAlwdP
	4DqftM1bS7NytY6sKhaOoKJOo5oBxaBCZozAltpKYiYFi5LDL8XP
X-Google-Smtp-Source: AGHT+IFfQqkMpSjtA7jus+wJ6ctMLzKEdrYUJjRCMfP2Vj6gsteQ1QmfQGjxZwZMF5QH+T3Puu0mWQ==
X-Received: by 2002:a17:907:50e:b0:a28:c2a9:44b4 with SMTP id wj14-20020a170907050e00b00a28c2a944b4mr81306ejb.17.1705000356695;
        Thu, 11 Jan 2024 11:12:36 -0800 (PST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id u13-20020a170906b10d00b00a2b3bb73b83sm904755ejy.94.2024.01.11.11.12.34
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 11:12:34 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55719cdc0e1so6444102a12.1
        for <rcu@vger.kernel.org>; Thu, 11 Jan 2024 11:12:34 -0800 (PST)
X-Received: by 2002:a17:906:392:b0:a2c:96e1:77ac with SMTP id
 b18-20020a170906039200b00a2c96e177acmr84710eja.46.1705000354137; Thu, 11 Jan
 2024 11:12:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111183252.GA797@neeraj.linux>
In-Reply-To: <20240111183252.GA797@neeraj.linux>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 11 Jan 2024 11:12:16 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgZdZ+GQBxntccu8FRkY1EzUL60JkcZtS-oQ=5CttZ_Ew@mail.gmail.com>
Message-ID: <CAHk-=wgZdZ+GQBxntccu8FRkY1EzUL60JkcZtS-oQ=5CttZ_Ew@mail.gmail.com>
Subject: Re: [GIT PULL] RCU changes for v6.8
To: "Neeraj Upadhyay (AMD)" <neeraj.iitr10@gmail.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, paulmck@kernel.org, 
	mingo@kernel.org, tglx@linutronix.de, rcu@vger.kernel.org, 
	boqun.feng@gmail.com, joel@joelfernandes.org, neeraj.upadhyay@amd.com, 
	urezki@gmail.com, qiang.zhang1211@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Jan 2024 at 10:33, Neeraj Upadhyay (AMD)
<neeraj.iitr10@gmail.com> wrote:
>
> Please pull the latest RCU git tree from:
>
>   https://github.com/neeraju/linux.git tags/rcu.release.v6.8

Not pulled yet - I have a big pile to go - but an ack that I got the email.

              Linus
