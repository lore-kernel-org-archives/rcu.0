Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C6E1EE02F
	for <rcu@vger.kernel.org>; Wed, 11 Jun 2025 19:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749671826; cv=none; b=YYTdiUIdFTx+FuyFkHAgOZ6YdC/EMZMQBfIRnoOm6ATuZZ3Zt2zCbcugrm2psj398P9c+cTVhxwMGiGmD1K2POnSGcdvP9w6ijLdUCp+O+Ybvdff8gemfi44DoneVtX4nhtO2G70JFHowPNGLwqbxHKMKy/P2KoPuxw9zAAcMUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749671826; c=relaxed/simple;
	bh=USvQ9wgruXH8TAOZtTOojRc6/1bENOZaHy0L6RZTwUY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=flD+0c1I1pQfzrynbhRyS9ZAG0hoFDG1CwIgtw/HvNIt1z2T4PvD4lrcUd4ADZgTbaJjK1ND4kiGpbxRzE3phjjYQFHrcFZqHWdLMq9pgub/3TWLdbAbOCByEIWahnIvk6JMmC5kC0x8br2oqKtATD1dyDu9q5blO0Pj3J9Ptvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3ddd5cd020dso3356595ab.0
        for <rcu@vger.kernel.org>; Wed, 11 Jun 2025 12:57:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749671824; x=1750276624;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xybNtyXqtvfuU44a4ETAFvRrnFPUW0N0SWVp+5H5Olw=;
        b=GB31DkGrDhgPfu2lnrZTqs67/3TlzBmPXBTs69dsQV5+X9NaPmY3Tglhwba/auNQMx
         wdVjY63lKtmN2NER6nLciVC54sNgV4u0jVz75fyXSTEB34auQGWcbngHtWeWuNhiv5pU
         0nWTqKGdTdjZBmm1491NgWcUzPnqIXqyp1wtJdHAkkNyzGZwOF3ccCDWYgtyuu2dqMmd
         IUnIwz9gqW7n3CLpiQUtkjQZ3mDsbSE4qg6tVXZ8A2Fxvs9drbX/Zx3j48H0sVEFifnR
         aq3POo5SbKLaT0tPkFTsGfhtCp+cH7B3tKJ3LdMv6dDYg9CWh7LvbfptBbibyQoSbrHO
         NXug==
X-Forwarded-Encrypted: i=1; AJvYcCVt5hCF2quDIcfcPAvUC3L12MCT8jFpW7asPH6uVDQFwAupU82Cj8UYTATBkB+6r3998qs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiVgX8dunpfkJsYGeyqO9zt13yoV/sEZioi3lBJkp2rzkDYx/B
	bSIFUrmuoSpUn8h5AcaaHeZpybdHyLtNk+nj+aGOpdjNh8JfNhByyB8PCrevdsBPQANVudO+TK3
	QQJZwDEv1H6wDe1TxnFUN5yBGIhmyxVtPP1v/FsW6W0MkI3hoX77icSCig/0=
X-Google-Smtp-Source: AGHT+IGaOiMEFXv47KOXSshI967qhIWt3XATRcvi4libIu+B5QOc5/g0VNunN6fwcDRO92g7JVoZgVqKP45pyMNnH4AnwbsEZal0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218a:b0:3dd:d6c2:51fb with SMTP id
 e9e14a558f8ab-3ddfa877098mr15583135ab.10.1749671824458; Wed, 11 Jun 2025
 12:57:04 -0700 (PDT)
Date: Wed, 11 Jun 2025 12:57:04 -0700
In-Reply-To: <aEnVuzK7VhGSizWj@pc636>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6849df90.a70a0220.cc01e.058d.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] [rcu?] BUG: unable to handle kernel NULL
 pointer dereference in rcu_core (3)
From: syzbot <syzbot+80e5d6f453f14a53383a@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, josh@joshtriplett.org, 
	kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, paulmck@kernel.org, 
	rcu@vger.kernel.org, syzkaller-bugs@googlegroups.com, urezki@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+80e5d6f453f14a53383a@syzkaller.appspotmail.com
Tested-by: syzbot+80e5d6f453f14a53383a@syzkaller.appspotmail.com

Tested on:

commit:         488ef356 KEYS: Invert FINAL_PUT bit
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=129a660c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=713d218acd33d94
dashboard link: https://syzkaller.appspot.com/bug?extid=80e5d6f453f14a53383a
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
patch:          https://syzkaller.appspot.com/x/patch.diff?x=170e460c580000

Note: testing is done by a robot and is best-effort only.
