Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DA6214225
	for <rcu@vger.kernel.org>; Thu, 12 Jun 2025 07:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749714166; cv=none; b=JpO63g2Y8lcSnx+X+RrSqbwGo1yLScMnD/6VbsuQFKy/rIHxh9YSZgkeWJxhxl16fk7zn85/7bERqUZfCd+/oU7kNsmPzKK5B+H0BGRIFe1znHfsTmJIcvO9/DdOzVN3HuNCt2eu2Npsvj+ukoOhKz5Mc/flHywnGRx64Ll/EGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749714166; c=relaxed/simple;
	bh=FOQXFaiVwO7dhrkbgNrBD2ORgwbO509L3NsVRqNVEVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J/l8Dvb8sI0IAgSCxX9AWMKTFbrpEgC5gc3jFyYqnR08i3Gs9m6DnfGMq0H15INz7oUQ2u0Vu4Rd599v49kakK/99qRHkhJREgzbUnZuixkXGz/gJva4or9cur6iNwAZVz+naiy5xt+Rpty6AEPT2ZC//149iTIyEuVh1wjb9XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qSfwi0d/; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qSfwi0d/"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-236470b2dceso6598275ad.0
        for <rcu@vger.kernel.org>; Thu, 12 Jun 2025 00:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749714164; x=1750318964; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/EqLSwnInI7/pMnd5ysWVbRy8uvQJPmZ91Nx+44JVcw=;
        b=qSfwi0d/Q3YbWvcH3abb1v/U4sMurxcSDSPjzXYbk9+9XLnPnMqcWOdFvWBKXeuTJh
         we0gKNyBP98BZgrPB95VV0h0rYKWa9CGn8XdT4Rk9dcBzdEHWFelLNqqgScxykOZ4DxU
         JUdnxG1+9y4Ag688nCexDNbFLcMCHyLDRqAS+yBs7hTcf1+LERbQZcCYubXXrIYecghG
         Fh0IWJV+q+E8EoTttE7T7YfkhDC7NidUrwsxud42A16rdeFzVKlV5wOmsF2mFOBpg8Pd
         Q2xv59/MFuuMgh4/DwQpsEkXIPeUwbyM7SrKK4CSsgKG/3+Q/KjAOL7564o8HhiZ38IE
         jOgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749714164; x=1750318964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/EqLSwnInI7/pMnd5ysWVbRy8uvQJPmZ91Nx+44JVcw=;
        b=iJF+FmZXMxXEVfcpaPeQ7ZAvRhgeXnJjPJzNkXrLnnXiox10LCuaA/Vq4NxBcAznK2
         m6PDQzxlMxk6aXX0syixNfPqDu+ISw74+jpomC/1ATL7yQ+/aEapxY9WP0VnercYA87B
         aNLj0EnSPsPKOhM0DWfM97UAeWZtByXdVUfUURWmzomGxO0zjq4/JoL7NQck08cqALLZ
         aifQqRQOOC6/ABm/52TgWeAtWIzpNB08Xo5qVatRAfnRwRCFxv2YJ3W1OQVrrxdtxJ42
         thDx8/XCAlPy+ru9SAbS7rI9kX5kq8eFk5qNDoTj4p7hZmHsPtt0XSVb4B0E5A4I/FWW
         zg/g==
X-Forwarded-Encrypted: i=1; AJvYcCW9Z/3opMvC+tldmiogG7z8PIdRRSlHkMGBe/3weIvyqGV+QRO2z2Ri3E+oijR5P400ejk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfjR1aazfEIzg+z4m2eZaGR5XfXILxp9CAonAKFfj1g13H/CWt
	9x+tnK/th8TF33lj5DvuLo7ErCTZr/+oOI7JSqNuO/owBur685ptOCv7AL8OvjJDJvA7BFlrni7
	NXuBpBjsGmq8VmX2tImKUGmFaVRHamA2kPzIjnYXJ
X-Gm-Gg: ASbGncvyx9MTQp00dqAuO6Lk5p/YdMbcc4aU7pg86cnU9S6gYJK0O0o1nollz3oB0lh
	qXDMyfPjbTnL52j+5GEcdLujukQ6MWovBW6MJo3jwmSDDu0o23FrpVx+fmMJvHRj3y6pB2ivE0k
	Nj19xUHwSZkq5u3sFMIwI+glRSfP9QlQUfSwtaOd5hv2zXSlionDLHsq2KKAMwEylUwD1u81966
	A==
X-Google-Smtp-Source: AGHT+IHWfz6ueRsBMvrL8ANKlYfntcz1uoa4QJR1XOifNxP+96m170S+IXM1efDQIk8mUoonHiE6qKHXDmQCeffxrW4=
X-Received: by 2002:a17:903:2448:b0:234:c86d:4572 with SMTP id
 d9443c01a7336-2364d8b7d4cmr29659685ad.30.1749714163932; Thu, 12 Jun 2025
 00:42:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aEnVuzK7VhGSizWj@pc636> <6849df90.a70a0220.cc01e.058d.GAE@google.com>
 <aEnuAp5w6QSoSu_M@tardis.local>
In-Reply-To: <aEnuAp5w6QSoSu_M@tardis.local>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Thu, 12 Jun 2025 09:42:32 +0200
X-Gm-Features: AX0GCFtO9O5G9ZnuVX3i1JpfXbgajBNsH_rdffk0L3gbJwN5FPeRccN9TijpSvM
Message-ID: <CANp29Y4d3de3cc9weuqHCw2sDMdtArOFz5B=783KZ4419Ux=Ag@mail.gmail.com>
Subject: Re: [syzbot] [bcachefs?] [rcu?] BUG: unable to handle kernel NULL
 pointer dereference in rcu_core (3)
To: Boqun Feng <boqun.feng@gmail.com>
Cc: syzbot <syzbot+80e5d6f453f14a53383a@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, josh@joshtriplett.org, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, paulmck@kernel.org, rcu@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, urezki@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 10:58=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> =
wrote:
>
> On Wed, Jun 11, 2025 at 12:57:04PM -0700, syzbot wrote:
> > Hello,
> >
> > syzbot has tested the proposed patch and the reproducer did not trigger=
 any issue:
> >
> > Reported-by: syzbot+80e5d6f453f14a53383a@syzkaller.appspotmail.com
> > Tested-by: syzbot+80e5d6f453f14a53383a@syzkaller.appspotmail.com
> >
> > Tested on:
> >
> > commit:         488ef356 KEYS: Invert FINAL_PUT bit
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D129a660c580=
000
>
> Is there a way to see the whole console output? If Ulad's patch fixes
> the exact issue, we should be able to see a WARN_ON_ONCE() triggered.

If WARN_ON_ONCE() were triggered, the associated kernel panic output
would have been at the end of this log.

>
> Regards,
> Boqun
>
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D713d218acd3=
3d94
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D80e5d6f453f14=
a53383a

FWIW the last time the bug was observed on syzbot was 100 days ago, so
it has likely been fixed since then or has become much harder to
reproduce.

> > compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07=
757-1~exp1~20250514183223.118), Debian LLD 20.1.6
> > patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D170e460c=
580000
> >
> > Note: testing is done by a robot and is best-effort only.
> >
>

--=20
Aleksandr
