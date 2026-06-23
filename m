Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F21A2DF3EA
	for <rcu@vger.kernel.org>; Tue, 23 Jun 2026 04:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782189409; cv=none; b=ikIN66bm+aiWJlyclfE1UVc8jcNxrZP09fsU9lVTtUiTZIFVaoZ07WojJV07Yfirs6JYXrBKzmjs2armUhQjncJXE+HC4jVm7OMDVw60M2HxsvQoXbK0Ao6Q5H99bZiHdThXCMIvZYpNEjJzi2kfy2xoiY30FxmYQWOwd9thkB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782189409; c=relaxed/simple;
	bh=n6nMMARM0X6AABdVweeX9/aLBCR+hwEeVXpsktkO1TA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RPVbg1PiT0aHxVAV2P/aqJdlTmGAgkyKh5EXl7LVARjRaovqwogAklQYduL+DFrRx/kxZOgE302FeyhQOiDG96M3R/vAhIXD+qc3pLpWk+kCg0Kqf5ue8E5rMOH6avZzsGUWvn4Hctjj15WcKSt60H38EjP5v30QMvpUht9/0nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tAtYyk7/; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tAtYyk7/"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84592b55832so241470b3a.3
        for <rcu@vger.kernel.org>; Mon, 22 Jun 2026 21:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782189407; x=1782794207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dt3pySXLLxRAVS12q4gDT3vSD9nb/FdqPRExCFEr4zc=;
        b=tAtYyk7/kwuY6U6b/kwSJDbPDhSOeps5/twIX/P0H+K5XKpOMaM4DyI9JqkbugTZht
         lJfAT7x5l9mF5tgorMwaBNNy19L4/arNBlTuX9Dre6bGsdait44MK5qpExj3QEc3jIWb
         +c5YHo5IwhARGyIwEs0kdS4libgpgHzB6my9Zo47UN6CuPJ76F+C4GZM9xip90laapBu
         /64sAug3fjM8YKTNUnQgvpeBd2bpMPw4RwMHKlVDo3znnewHlHg9QgwBmmV/f2lfgm0h
         A5AkeDtv5gHduQLRjSDR1djwjl0mrhXls0+q/NlqLBvfr2V2yGu0dxuKnvZtq6R32qId
         TDaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782189407; x=1782794207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Dt3pySXLLxRAVS12q4gDT3vSD9nb/FdqPRExCFEr4zc=;
        b=oa8uxL/ExefhK2ux2KlSdwqn5Ji47N0eUilz7AVkRDbNBM/5AicoyoRw7wcvYvOtXE
         8c42hfx8ax4brnln7krEYUC5XD4GIfo9ZVDfcqGVd8AZazRnkVfQdEdqEC41igK4gAMk
         e70yh1oQRHi/uQFyWRv0aAgQXSZMnWy4pd9zxvwjRp1t9UpORXuEzQ9CZHfSh2a7Fy3t
         keJmqfkFkgkWgeEZe+10gaVTgCyhu+AKbwXC6gvvbdBho7LpFPhMpLNNZZ1+l/Ybe9OS
         PZAN9Mz426giEc7hRrVmZDzGbRBhzsa3zQdawBJm0sqtNIpxZLXIRs7BSdKEammZvQw6
         0uyA==
X-Forwarded-Encrypted: i=1; AFNElJ+nYQm6HBhJwc3gZjeivEwyhW2WJNKGQI5/WM6I9XKJ0ZL/qGCUoeqvtMv4YcG3Isu4nvo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5H7AaM9SMxWfek7Z+Y80/DgIxjQDS3n7WUaVQUyW08oqDyTCt
	ZPpbwp2JqnnRsBt7eGpkJpU52IjhCppI2SBRCdsyOwgg0Ee7wSAi0Tn95bNTJ51S
X-Gm-Gg: AfdE7cl6KqSmBuony5NLw/4PG9/b4zUadGxEysNyCI3Z2mC2re5alteuE7BLBBaKORW
	L6zYvg23dBG3tIZur+ug8qkxGO+nPO4XIfFiJHdL5zOsi2SCknXJ37fSGIyIdmoA8LIOHtkt+/1
	hCDXV5a9CL9apePQklMrhpVHDZc1li9ccImktbTi6O1ZihzbAsRXIQqBOd7GP3IYyfxEsTR2Xl1
	4/hFWx28FKjQ/6jZBGf0RGgq2RCelDapLjZa+i5wL2Ca8YhNDG6RHa1EBXlOQd+5EKCF+QWTlig
	T17gf++xzpd/pAUOlD3SdD5vKqG+ZO4ft3KesA0vXDcGCo+ynotIqB4lghceDukNOKsnhzkct20
	yvR9sSKfdIsIxJEZFDj1PApLc9SOFmO7huUdg3RO+j4FHhHwnEQqeiuU7whCT5dEkKBhHmsb/Z8
	5KkILwRPQ=
X-Received: by 2002:a05:6a00:f0d:b0:842:5ea5:5ff8 with SMTP id d2e1a72fcca58-845954402fbmr1535070b3a.42.1782189406881;
        Mon, 22 Jun 2026 21:36:46 -0700 (PDT)
Received: from ubuntu.. ([138.199.21.246])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564d6c2cesm11059604b3a.2.2026.06.22.21.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 21:36:46 -0700 (PDT)
From: Jing Wu <realwujing@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: Jing Wu <realwujing@gmail.com>,
	Waiman Long <longman@redhat.com>,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	cgroups@vger.kernel.org,
	Qiliang Yuan <yuanql9@chinatelecom.cn>
Subject: Re: [PATCH v3 08/13] genirq: Add explicit housekeeping callback for managed IRQ migration
Date: Tue, 23 Jun 2026 12:36:41 +0800
Message-ID: <20260623043641.2391662-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <87cxxnegqa.ffs@fw13>
References: <87cxxnegqa.ffs@fw13>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, Jun 18 2026 at 22:27, Thomas Gleixner wrote:
> While this series might work for you by some definition of "works",
> it's broken beyond repair [...]
> Please coordinate with Waiman or whoever is working on it at RH right now.

Thank you for the detailed review. I want to clarify the timeline and
highlight a key distinction before proceeding with v4.

DHM was posted as RFC on 2026-02-06 [1], v1 on 2026-03-25 [2], and v2
on 2026-04-13 [3]. Waiman Long's series was posted on 2026-04-20 [4],
seven days after DHM v2. The development appears to have been parallel.

More importantly, DHM and Waiman's series differ in a key requirement:
Waiman's series requires "nohz_full=" to be present at boot (even with
an empty CPU list) to opt into runtime updates. DHM's goal is to enable
CPU noise isolation at runtime on systems where no nohz_full= was
configured at boot — a use case his series does not cover.

That said, I fully accept the architectural feedback: the on-the-fly
subsystem modification approach in v3 is wrong, and v4 should use the
CPU hotplug machinery.

We are open to coordinating with Waiman on a unified approach that
covers both use cases. Before starting v4, two questions:

  1. Is the "no boot parameter required" use case worth pursuing
     independently, or should it be folded into Waiman's series?

  2. For the hotplug path: is CPU-by-CPU offline/online the expected
     mechanism, given that you rejected the cpuhp_offline_cb() bulk
     approach in Waiman's v1?

[1] https://lore.kernel.org/r/20260206-feature-dynamic_isolcpus_dhei-v1-0-00a711eb0c74@gmail.com
[2] https://lore.kernel.org/r/20260325-dhei-v12-final-v1-0-919cca23cadf@gmail.com
[3] https://lore.kernel.org/r/20260413-wujing-dhm-v2-0-06df21caba5d@gmail.com
[4] https://lore.kernel.org/r/20260421030351.281436-1-longman@redhat.com

Jing Wu <realwujing@gmail.com>
