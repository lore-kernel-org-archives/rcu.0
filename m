Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CAA276046
	for <rcu@vger.kernel.org>; Wed, 11 Jun 2025 18:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749664925; cv=none; b=PYFDCHYMDwYYmYupc8VnsP7m9E7JN010bxpxW7xvJldIQWAggcZWRsDOm6udl0iyOxx5rjxWYMtP0qWcfsfBKEitwSSbS7tkMdA/Ehbv2OG5iXTqfEC8PvsNKGwCgEa1w6CUwjEYbKAKvhRszm1riW7Xwetl56bjgDaJnKgNspI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749664925; c=relaxed/simple;
	bh=V1E7f5QusoelLMUHp3Yu2uLJI3CUAyfmQYr4cJCS8jM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CWncNJm3NnM5wZV8KA1AvkEPU2SsxNcuNpNlPH6hFz4Cg8fQ0E7pIEcmlHvTmzrV/po9gmMDPKtcXImSmHpIeCQxzhp/wmLy+bH0o4+38eZ3rb79AVxr/o74H5fHrZU8QrNCAx1tWM6ifrewpMUN4JWI48pxSmsLFo2F+2ZE3Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-86cf753423cso14048939f.3
        for <rcu@vger.kernel.org>; Wed, 11 Jun 2025 11:02:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749664923; x=1750269723;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DnYzrXJvnrK56gfoRm+seV41wic4hiIzCla9ZFzIcZQ=;
        b=pgDiPJeckH5sUW3jyFJ0Yyrwu/WU0PJL0oNv9l3hnSdeZ9xEnIKRWWB7BSOLfD/Xc7
         pIVrn01l57U30c9TFLC1bAupx8bzXWJrS76AFpOQWQfm08Wfyf+RU6Ynmy/JLs+8jUDG
         Z3yid+srLqQfkANmWgFbGxQb6wjCKPfmgiItT5uRDlJbyJGr+rwCBC3fbm8q2fhYKQDo
         LlOhbBFFTDPltWd1bpmKrF35xYq0NrcasaeqhaemDCCEhMD/M50e0BQIQ8jLj+MU2Qew
         sfX3jzfphY1senUjzcOahleb6KgZ5O6uciZsNS0/SMvspKrkYvPKRFAubAp2cZdpzoGP
         romg==
X-Forwarded-Encrypted: i=1; AJvYcCUckJhBATaceRYRHKzIqrvv8KyEYD8wbzBCi0Jc52TP4LLKLt8/DlBVtxwD49Owu9PjE7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcYFhzHwIpCcoLVDv0KBzXIAf4jdnCCx9VIhSJiX8ZYK9BMAgc
	BXCcugL3S4Y8KOKDuQixRhuQzvRRuS0e/F8QqvmvsqmO28BLmL39rI3vHUT+NrbCig1QZPaPFA2
	gCPBoqt+paCXoNZKm53JmRK4OhSci+HiNnPANWrD+qsg1UPfQ3mbgqBuO0yQ=
X-Google-Smtp-Source: AGHT+IG8FjKx8LRHz/LA6R14C5WI1KhK0i9zeWL0MvJYVAiFKjgXESDWMm2bojrctLpZZlo55eSEZzjkqthnuN/oJbHiKPzJYNvT
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:184a:b0:3dd:ceb0:f603 with SMTP id
 e9e14a558f8ab-3ddf42391cemr50493975ab.2.1749664923258; Wed, 11 Jun 2025
 11:02:03 -0700 (PDT)
Date: Wed, 11 Jun 2025 11:02:03 -0700
In-Reply-To: <aEmnv69zbkinkDVs@pc636>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6849c49b.a00a0220.1eb5f5.00f2.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] [rcu?] BUG: unable to handle kernel NULL
 pointer dereference in rcu_core (3)
From: syzbot <syzbot+80e5d6f453f14a53383a@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, josh@joshtriplett.org, 
	kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, paulmck@kernel.org, 
	rcu@vger.kernel.org, syzkaller-bugs@googlegroups.com, urezki@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file kernel/rcu/tree.c
patch: **** unexpected end of file in patch



Tested on:

commit:         aef17cb3 Revert "mm/damon/Kconfig: enable CONFIG_DAMON..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=523d3ff8e053340a
dashboard link: https://syzkaller.appspot.com/bug?extid=80e5d6f453f14a53383a
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17de99d4580000

