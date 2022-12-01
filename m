Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B31C43217
	for <rcu@archiver.kernel.org>; Thu,  1 Dec 2022 07:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiLAHnn (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 1 Dec 2022 02:43:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiLAHnk (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 1 Dec 2022 02:43:40 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1740442C0
        for <rcu@vger.kernel.org>; Wed, 30 Nov 2022 23:43:38 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id e141so992092ybh.3
        for <rcu@vger.kernel.org>; Wed, 30 Nov 2022 23:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n/cSfJyuw306M41Dp+L+BI0/0zq6sfGvI8BbkoukRHo=;
        b=kJrxYS8ifZi++NNhu7Qf+KtFc8uekfyczf2pLWdBbxXH/aASZ/RXOrOk8MtPahSwbL
         dSES1VZ6n5tlydFOcRs6UHHSoboIs6gNKuXLVq0acyLDw8/vSSGSkJAnYlPWrI/KUphq
         chEdKyfPUoutY0nNxv4dXHykwKcl3a6OcYo1R5Qxn2KMc3YGcK2HdyJ/T/3eKHWtWQdl
         fMf6Y5EFK1kdcIrfXQvoN73b6K+x8yT35SBSXL7vomFXH9ZxT5/A1qpmhMHzu4ZKR3an
         9vURQPEg/mCHVEo4JP6LgAW7kJWyEXHEwwoThXDe/82DMC1yHODZYZ3rAHnq1FhHT05a
         J3VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n/cSfJyuw306M41Dp+L+BI0/0zq6sfGvI8BbkoukRHo=;
        b=0VRqOjmeGHB4MK2piOT8gh5L2yH8r+vAeqQQVStJVdfH3SX1eZhlNmKAH/J2paxwGr
         xlfXUB+K7esnFiqe6jeh3RAevCezLhmN2E6BCv8uAZgOgSR7ISUHmTu/F5MslIH2n4OZ
         VigO7AXw44dtIRKZ29H8wQ3pOEMaU5L91GwecolgbeZ+0XJVG4kMwj+aas74Tx+pZC0/
         nu8YT2pZ6eOTCgrJt5NmjJWorjmc/Xz4otOPfRtJSkyrlYODD0tQlbIExz5Q7hfUU5lG
         LVMPfb8IqffYNdDp130uOVzJvlbARHoQHp2yuQKy2WrtEMf6eoshF0QOIeJRe7qzR0U1
         zxcQ==
X-Gm-Message-State: ANoB5pnRubq1sdn0yKjqx5LhVEKiOq8XdYsJvZEaMGjIuT8wUQ0p2tDm
        RytHxuSQG5f8jpwD8jg2GP/2bu6wRWTpSy36ISISew==
X-Google-Smtp-Source: AA0mqf58zbiU2tOdgfpIyYwAtowOVuJiYQYGedVWE37iNqvP8PDnpM1y2y1xatVDhqnnQ8TB+MnNjkUHPLwvaS1G16c=
X-Received: by 2002:a25:d782:0:b0:6f5:6b11:8110 with SMTP id
 o124-20020a25d782000000b006f56b118110mr19813207ybg.560.1669880617677; Wed, 30
 Nov 2022 23:43:37 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYsK5WUxs6p9NaE4e3p7ew_+s0SdW0+FnBgiLWdYYOvoMg@mail.gmail.com>
 <CANpmjNOQxZ--jXZdqN3tjKE=sd4X6mV4K-PyY40CMZuoB5vQTg@mail.gmail.com>
 <CA+G9fYs55N3J8TRA557faxvAZSnCTUqnUx+p1GOiCiG+NVfqnw@mail.gmail.com> <Y4e3WC4UYtszfFBe@codewreck.org>
In-Reply-To: <Y4e3WC4UYtszfFBe@codewreck.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 1 Dec 2022 13:13:25 +0530
Message-ID: <CA+G9fYuJZ1C3802+uLvqJYMjGged36wyW+G1HZJLzrtmbi1bJA@mail.gmail.com>
Subject: Re: arm64: allmodconfig: BUG: KCSAN: data-race in p9_client_cb / p9_client_rpc
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Marco Elver <elver@google.com>, rcu <rcu@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        kunit-dev@googlegroups.com, lkft-triage@lists.linaro.org,
        kasan-dev <kasan-dev@googlegroups.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: multipart/mixed; boundary="00000000000008f9c705eebf61a4"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

--00000000000008f9c705eebf61a4
Content-Type: text/plain; charset="UTF-8"

On Thu, 1 Dec 2022 at 01:35, Dominique Martinet <asmadeus@codewreck.org> wrote:
>
> Naresh Kamboju wrote on Wed, Nov 30, 2022 at 09:34:45PM +0530:
> > > > [  424.418214] write to 0xffff00000a753000 of 4 bytes by interrupt on cpu 0:
> > > > [  424.422437]  p9_client_cb+0x84/0x100
> > >
> > > Then we can look at git blame of the lines and see if it's new code.
> >
> > True.
> > Hope that tree and tag could help you get git details.
>
> Even with the git tag, if we don't build for the same arch with the same
> compiler version/options and the same .config we aren't likely to have
> identical binaries, so we cannot make sense of these offsets without
> much work.
>
> As much as I'd like to investigate a data race in 9p (and geez that code
> has been such a headache from syzbot already so I don't doubt there are
> more), having line numbers is really not optional if we want to scale at
> all.
> If you still have the vmlinux binary from that build (or if you can
> rebuild with the same options), running this text through addr2line
> should not take you too long.

Please find build artifacts in this link,
 - config
 - vmlinux
 - System.map
https://people.linaro.org/~anders.roxell/next-20221130-allmodconfig-arm64-tuxmake-build/

And

 # aarch64-linux-gnu-objdump -D vmlinux|less search for p9_client_cb

Attached objdump log and here is the link.
    - http://ix.io/4hk1

> (You might need to build with at least CONFIG_DEBUG_INFO_REDUCED (or not
> reduced), but that is on by default for aarch64)

Thanks for the suggestions.
The Kconfig is enabled now.
CONFIG_DEBUG_INFO_REDUCED=y

> --
> Dominique


- Naresh

--00000000000008f9c705eebf61a4
Content-Type: text/plain; charset="US-ASCII"; name="objdump-p9_client_cb.txt"
Content-Disposition: attachment; filename="objdump-p9_client_cb.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_lb4rmdbt0>
X-Attachment-Id: f_lb4rmdbt0

ZmZmZjgwMDAwYTQ2Y2FjMCA8cDlfY2xpZW50X2NiPjoKZmZmZjgwMDAwYTQ2Y2FjMDogICAgICAg
ZDUwMzIwMWYgICAgICAgIG5vcApmZmZmODAwMDBhNDZjYWM0OiAgICAgICBkNTAzMjAxZiAgICAg
ICAgbm9wCmZmZmY4MDAwMGE0NmNhYzg6ICAgICAgIGQ1MDMyMzNmICAgICAgICBwYWNpYXNwCmZm
ZmY4MDAwMGE0NmNhY2M6ICAgICAgIGE5YmM3YmZkICAgICAgICBzdHAgICAgIHgyOSwgeDMwLCBb
c3AsICMtNjRdIQpmZmZmODAwMDBhNDZjYWQwOiAgICAgICA5MTAwMDNmZCAgICAgICAgbW92ICAg
ICB4MjksIHNwCmZmZmY4MDAwMGE0NmNhZDQ6ICAgICAgIGE5MDE1M2YzICAgICAgICBzdHAgICAg
IHgxOSwgeDIwLCBbc3AsICMxNl0KZmZmZjgwMDAwYTQ2Y2FkODogICAgICAgYWEwMTAzZjMgICAg
ICAgIG1vdiAgICAgeDE5LCB4MQpmZmZmODAwMDBhNDZjYWRjOiAgICAgICBhYTFlMDNmNCAgICAg
ICAgbW92ICAgICB4MjAsIHgzMApmZmZmODAwMDBhNDZjYWUwOiAgICAgICBhOTAyNWJmNSAgICAg
ICAgc3RwICAgICB4MjEsIHgyMiwgW3NwLCAjMzJdCmZmZmY4MDAwMGE0NmNhZTQ6ICAgICAgIDJh
MDIwM2Y2ICAgICAgICBtb3YgICAgIHcyMiwgdzIKZmZmZjgwMDAwYTQ2Y2FlODogICAgICAgYWEw
MDAzZjUgICAgICAgIG1vdiAgICAgeDIxLCB4MApmZmZmODAwMDBhNDZjYWVjOiAgICAgICBmOTAw
MWJmNyAgICAgICAgc3RyICAgICB4MjMsIFtzcCwgIzQ4XQpmZmZmODAwMDBhNDZjYWYwOiAgICAg
ICBhYTE0MDNmZSAgICAgICAgbW92ICAgICB4MzAsIHgyMApmZmZmODAwMDBhNDZjYWY0OiAgICAg
ICBkNTAzMjBmZiAgICAgICAgeHBhY2xyaQpmZmZmODAwMDBhNDZjYWY4OiAgICAgICA5MTAxYmE3
NyAgICAgICAgYWRkICAgICB4MjMsIHgxOSwgIzB4NmUKZmZmZjgwMDAwYTQ2Y2FmYzogICAgICAg
YWExZTAzZTAgICAgICAgIG1vdiAgICAgeDAsIHgzMApmZmZmODAwMDBhNDZjYjAwOiAgICAgICA5
NzgzNGIyMCAgICAgICAgYmwgICAgICBmZmZmODAwMDA4NTNmNzgwIDxfX3RzYW5fZnVuY19lbnRy
eT4KZmZmZjgwMDAwYTQ2Y2IwNDogICAgICAgZjAwMDM2MTQgICAgICAgIGFkcnAgICAgeDIwLCBm
ZmZmODAwMDBhYjJmMDAwIDxldmVudF90eXBlX3NpemUrMHg4PgpmZmZmODAwMDBhNDZjYjA4OiAg
ICAgICBhYTE3MDNlMCAgICAgICAgbW92ICAgICB4MCwgeDIzCmZmZmY4MDAwMGE0NmNiMGM6ICAg
ICAgIDk3ODM1Y2FkICAgICAgICBibCAgICAgIGZmZmY4MDAwMDg1NDNkYzAgPF9fdHNhbl9yZWFk
Mj4KZmZmZjgwMDAwYTQ2Y2IxMDogICAgICAgNzk0MGRlNjMgICAgICAgIGxkcmggICAgdzMsIFt4
MTksICMxMTBdCmZmZmY4MDAwMGE0NmNiMTQ6ICAgICAgIDkxMWM4Mjk0ICAgICAgICBhZGQgICAg
IHgyMCwgeDIwLCAjMHg3MjAKZmZmZjgwMDAwYTQ2Y2IxODogICAgICAgOTEzODQyOTQgICAgICAg
IGFkZCAgICAgeDIwLCB4MjAsICMweGUxMApmZmZmODAwMDBhNDZjYjFjOiAgICAgICA1MjgwMDQw
MCAgICAgICAgbW92ICAgICB3MCwgIzB4MjAgICAgICAgICAgICAgICAgICAgICAgIC8vICMzMgpm
ZmZmODAwMDBhNDZjYjIwOiAgICAgICBhYTE0MDNlMSAgICAgICAgbW92ICAgICB4MSwgeDIwCmZm
ZmY4MDAwMGE0NmNiMjQ6ICAgICAgIGIwMDA2YTIyICAgICAgICBhZHJwICAgIHgyLCBmZmZmODAw
MDBiMWIxMDAwIDxrYWxsc3ltc190b2tlbl9pbmRleCsweDIwZjA3MD4KZmZmZjgwMDAwYTQ2Y2Iy
ODogICAgICAgOTEwYTgwNDIgICAgICAgIGFkZCAgICAgeDIsIHgyLCAjMHgyYTAKZmZmZjgwMDAw
YTQ2Y2IyYzogICAgICAgOTdmZmYzNDUgICAgICAgIGJsICAgICAgZmZmZjgwMDAwYTQ2OTg0MCA8
X3A5X2RlYnVnPgpmZmZmODAwMDBhNDZjYjMwOiAgICAgICA1MjgwMDA4MCAgICAgICAgbW92ICAg
ICB3MCwgIzB4NCAgICAgICAgICAgICAgICAgICAgICAgIC8vICM0CmZmZmY4MDAwMGE0NmNiMzQ6
ICAgICAgIDk3ODM0ZGUzICAgICAgICBibCAgICAgIGZmZmY4MDAwMDg1NDAyYzAgPF9fdHNhbl9h
dG9taWNfc2lnbmFsX2ZlbmNlPgpmZmZmODAwMDBhNDZjYjM4OiAgICAgICBkNTAzM2FiZiAgICAg
ICAgZG1iICAgICBpc2hzdApmZmZmODAwMDBhNDZjYjNjOiAgICAgICBhYTEzMDNlMCAgICAgICAg
bW92ICAgICB4MCwgeDE5CmZmZmY4MDAwMGE0NmNiNDA6ICAgICAgIDk3ODM1YWMwICAgICAgICBi
bCAgICAgIGZmZmY4MDAwMDg1NDM2NDAgPF9fdHNhbl91bmFsaWduZWRfd3JpdGU0PgpmZmZmODAw
MDBhNDZjYjQ0OiAgICAgICBhYTEzMDNlMCAgICAgICAgbW92ICAgICB4MCwgeDE5CmZmZmY4MDAw
MGE0NmNiNDg6ICAgICAgIGQyODAwMDAzICAgICAgICBtb3YgICAgIHgzLCAjMHgwICAgICAgICAg
ICAgICAgICAgICAgICAgLy8gIzAKZmZmZjgwMDAwYTQ2Y2I0YzogICAgICAgNTI4MDAwMjIgICAg
ICAgIG1vdiAgICAgdzIsICMweDEgICAgICAgICAgICAgICAgICAgICAgICAvLyAjMQpmZmZmODAw
MDBhNDZjYjUwOiAgICAgICA1MjgwMDA2MSAgICAgICAgbW92ICAgICB3MSwgIzB4MyAgICAgICAg
ICAgICAgICAgICAgICAgIC8vICMzCg==
--00000000000008f9c705eebf61a4--
