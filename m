Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795440007;
	b=FRUUL12dMSqdGglqr3VMtlAWGqThEzJ0iwkFfhlNAEQJGaAge1dD285RQ54HSfxbcC9x
	 Mv5Gn8RH1nwLyKkc/C64qnXqU/B0CYBWh9YVcXMzZEwQI/XVsG2+5IGxFKSe19lEAyWyl
	 z8XTWq2IagcVR7LXjck0kQwtxR24Yn3dq0vIea49XzYq+JN8JH5v2A+Bp/EcgVK5/Acky
	 KZxT7+EB6iBRNaYi0gZhOXqqIXU4/IKEU+ulXti96U5z8epx+nwrL6txPYfcis3FZINtt
	 s6zHoCWNgdZ5Sm+qOC0ysq51WIHm6UTX+n2obHDeW343B39TN1Bx8kaCYAbXgaoy2Gg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795440007;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=Cux1q2zTGzqkom+b4m1/fgFXJParUvZagzTBGFrsucc=;
	b=ECJfC6Nx/XjC6LR8cyIaHPb7b26ZTDu4v3rhgtWM7P2ElI7jWcqyLuPq1kPRQz4Y6hVo
	 OrRYybWz5fvHjujCC3sUo9i4y8Qiv6KGEkqlmzFRif0Omc7pSxEAR5HnGRdSXJeHx7I/D
	 NLUpQSrYzc8yCf0sbQXv9C5W984H7DpoGz0m1ORu6dfHgSoku0nbaNjcTur705alffPIm
	 CwIuRlNdqu1JkVSyIp16H2AXvRTx3GlUvTb9tUbFDWUTUzh+difHPyEXCXb2171DuDu47
	 NYq4nIb23Cht5F3uzincdW9TifLAirOQV4fYc5ZLXZhCDz/qV5soW514QMM9h9PSg3g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ionos.com;
	spf=pass smtp.mailfrom=ionos.com;
	dkim=pass header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=K6JjSUC+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F50606A31E
	for <rcu@vger.kernel.org>; Mon, 23 Nov 2026 13:20:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98F50606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=K6JjSUC+
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b8a1f59d5eso4044739a12.3
        for <rcu@vger.kernel.org>; Mon, 23 Nov 2026 05:20:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795440005; cv=none;
        d=google.com; s=arc-20260327;
        b=b/Unmm3SNCjkGuLcKznbzQLg04ylCgUoWRrXIUFZN4Rihbobz6VOFSW8ONjVv46zEq
         DzSaRPASEF1saNCvoJFYB/iY7nDbpkMDLxRIlL3peahsIL2JTAGdeC5PJ+7y7pvX34ro
         eofRei76kPfSoQCAus0PQHYthAtvn6PsgoR3iIL1up9ftfbtHUu8mV4WF4fSs5xb65LJ
         dT7E2xJ5QQuTYdOMJdw97ekSO+rpnxanQB7NxGWhnObHcWKDxV9T7if5aievz9qDm+Mf
         OyW/GX/fHCG6hm41q2d2PEaORAZS8y6Ma0T8WdAjjIcCM7ziS6mvUraoOatFEDS+/i7O
         5zLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Cux1q2zTGzqkom+b4m1/fgFXJParUvZagzTBGFrsucc=;
        fh=0OStOfVj2rfLRUhYaNH22mYeO9z00WHJ/fUtqAvWGHw=;
        b=jt+3oAnlrQ5cSMCY+cW0G70ayMyljaKb32EiCNCzwg/mG0N4E7JPLB25Uenum/nf4K
         2F/qvFLBQoPN6//Vkn02T9qk0A7cM7hUsw92Bo+q0tSA5e3S4u7tdTP49F7uqBuSg+PM
         a2B4ACPrYvPw8knQYZpXBSzLzwlrjb7T+4e8SCKHrgZOUZ5nrpnrP+xofatRgFJFdKXc
         d1uN86Hfbx94Qs4EsqNaAR+8zp5a993uDepSjIaKda/klP6EoMLg+unxlucdmUInzS5T
         BFkorJsXOzSNL8+npthe2OrDRiFy8VgUYk/mcIe9MLlTuFdIw0YhMCKmuzdDbxPdOF3I
         dLGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1795440005; x=1796044805; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cux1q2zTGzqkom+b4m1/fgFXJParUvZagzTBGFrsucc=;
        b=K6JjSUC+v6DA22cizA+pl+gCKMugyrkcWcBPt001jUNW6jHzpfMahk/Z5l0QqXW+Tt
         GEJpPV6ji0wIz/VrRriuUytbwED+u6QZwvGw6PC6HxBUHqjt3LGDhhGydsYvJ6Gsbfot
         E70gGC21rrzRfke2PfJH6tZF6ohYO3axvXlnm6Sepi8G0byCUR5LFtjpYlVdNHhDzvyc
         b655msW9o9ze3T6bxUkv2HkW13N1eBsVZNJ/jHYd61bZa22ElGMJ4TxkZ7HqeJ++HdlN
         X85n1FDpI41JEFr85eboBC5Pew0Q639xrjQ5/QNvz/TyNdon0pB9PVMPzxzPok1e5i3n
         PqfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795440005; x=1796044805;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Cux1q2zTGzqkom+b4m1/fgFXJParUvZagzTBGFrsucc=;
        b=vBdoxnPOpNvYEMJ1/kHYNqWSueeuDEwXPSvOeAuvT5gJtQj7gz5ZmZKy+EaSLsczHx
         OjBR74cgtV76mnV0YQdNh26WvUpvIR+TTA8BrHxJrO2jShNEI0r6Cvjy9Vy83cb3khZV
         N+7YewfIDlK9ivS5qil40pUQmFIt58N7vjbBFHj9Rkwl71nP710A+KW6xdAyIfaYDnhe
         gU+ZMEOzIlVXxiuaO4hkrvOe/AiOS2tiOIevgm33XcDWo5JnIksxwWdmaCIyVl4DV4R+
         X5RO8m78ErxOVscjeahdh3m+29HnLOBVIQ5+nF24PAep97dX2HswgkVKYP9X5IM56C5c
         +lKA==
X-Forwarded-Encrypted: i=1; AL+hErEuDdbwxgZsigSD21cYh4nkPSmwPzO9mM/Cxn5rGZTADb4mS1hgRJTcVVK5lHIRtJDXWP8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+xrZ/bWc17tRN0dwq5mA6maZrbWkgy5pBGS7BRpwHasZU7U0hH
	8nQpch+6s4r8JvfoF41Zg0tkQ6KtksnyElyMX/n/IHfbgdWVHa6c3N3YSwOikl2hxu0JyVUfMKP
	oaQw6hA4aYBQkAIdujXWvz2nOWxQHLOzv0ruE23wdlg==
X-Gm-Gg: AZFdTZdS1Edlmp86y8wgVzBKjN30FRHqu6psWGt3jYObhOFJyBkea/9GHDLGuEO1u4N
	ku4ko+XqExAiUGE9B2l1mOg+DiB9QGFfeQiBn0Nnlf6cVZpDYTQqit4X3NzHWe34C9NT3FNPmsR
	jjqaaPdVEOz2O0PjM5cCFu7CenE7HS8cXfSiDO4AnrylVKy89zV6eAwLVF82EtPSS1uA/iwDw6I
	FP+yqGSzMovf1FwYJjFXFl1gwA4PfJEVoqdJ94Eq03aMCQVt89R0QVoaueH8uiHSluTGqFNTUzj
	OklU72RaRBt+bAcxyJVx9kYQp7jDXG6DAY9VqZ8OrggQF+uspdWbeAnIffEB17VCxtFlkVR47Qd
	WY8lg79Ai+U96CrwLdE8CY5BnWhCzoH6PYnL8UxuHDJfv1yWd9xdWTu9p9XsbH+uJXg==
X-Received: by 2002:a17:906:447:b0:c46:cc9e:a143 with SMTP id
 a640c23a62f3a-c513ab1d008mr716021166b.26.1795440004829; Mon, 23 Nov 2026
 05:20:04 -0800 (PST)
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103113711.1832834-1-max.kellermann@ionos.com>
 <20261103113711.1832834-5-max.kellermann@ionos.com> <CAGsJ_4wpd-e+xjm5KwihVziAeVnQp3XYG=+-BKmx0SVEhmyqqw@mail.gmail.com>
 <CAKPOu+9textOydxZYng=Bo9Sf91Wq_7rv5r2pBrhXOfiex=qGA@mail.gmail.com> <CAGsJ_4zzZZSaAwG=VLhuMvoD0YcAFdqyUr-8zRSibNw28j8wzQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4zzZZSaAwG=VLhuMvoD0YcAFdqyUr-8zRSibNw28j8wzQ@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 23 Nov 2026 14:19:53 +0100
X-Gm-Features: Aa3M54r6cbzKznLbRSijNuzXT2VmkZ0RfouvSkd09nroJFvuUAh1A-K_PM2wVL0
Message-ID: <CAKPOu+8oMMQKSMLL04QqULtx03reOPJBmw6EtSHbYCyoZQ83Bg@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] mm/mglru: avoid redundant rotations of young memcgs
To: Barry Song <baohua@kernel.org>
Cc: akpm@linux-foundation.org, kasong@tencent.com, qi.zheng@linux.dev, 
	shakeel.butt@linux.dev, axelrasmussen@google.com, yuanchu@google.com, 
	weixugc@google.com, baoquan.he@linux.dev, baolin.wang@linux.alibaba.com, 
	david@kernel.org, ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000b450f30660f17354"

--000000000000b450f30660f17354
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 10:08=E2=80=AFAM Barry Song <baohua@kernel.org> wrot=
e:
>
> On Wed, Nov 4, 2026 at 4:27=E2=80=AFPM Max Kellermann <max.kellermann@ion=
os.com> wrote:
> >
> > On Wed, Nov 4, 2026 at 6:18=E2=80=AFAM Barry Song <baohua@kernel.org> w=
rote:
> > > > In my micro benchmark, this increases the request rate by 36% and
> > > > reduces the average duration of each write request by 27%.
> > >
> > > Could you share your microbenchmark somewhere (or post it here
> > > if it's not too lengthy), perhaps on GitHub, so others can
> > > reproduce it? You could then refer to it in your changelog.
> >
> > Will do.  A note of warning: it's ugly LLM slop, and if I had written
> > it manually, probably 99% of it could be removed because it's
> > pointless garbage.  The LLM wrote it for me before I had any clue
> > where the problem could be.  It helped me find the problem, but
> > uploading this garbage triggers a bit of shame in me ;-)

Here's the script; to avoid the pain of reading it, I let the LLM
remove lots of features that turned out to be unnecessary for
reproducing the problem. Prepare with:

 echo 3 >/sys/kernel/mm/lru_gen/enabled; ./lrugen-repro.py prepare --live 1=
500

Then run:

 ./lrugen-repro.py run --workers 8 --duration 60

--=20
Max Kellermann
Principal Architect
Hosting Technology

cm4all | Im Mediapark 6a | 50670 K=C3=B6ln | Germany
General information about the company can be found here:
https://www.cm4all.com/impressum
A member of the IONOS Group

--000000000000b450f30660f17354
Content-Type: text/x-python; charset="US-ASCII"; name="lrugen-repro.py"
Content-Disposition: attachment; filename="lrugen-repro.py"
Content-Transfer-Encoding: base64
Content-ID: <f_mwtal3re0>
X-Attachment-Id: f_mwtal3re0

IyEvdXNyL2Jpbi9lbnYgcHl0aG9uMwoiIiJFeGVyY2lzZSBNR0xSVSBtZW1jZyByb3RhdGlvbiBv
biBhIGRlZGljYXRlZCBjZ3JvdXAtdjIgdGVzdCBob3N0LgoKUnVuIGFzIHJvb3Q6CiAgLi9scnVn
ZW4tcmVwcm8ucHkgcHJlcGFyZSAtLWxpdmUgMTUwMAogIC4vbHJ1Z2VuLXJlcHJvLnB5IHJ1biAt
LXdvcmtlcnMgOCAtLWR1cmF0aW9uIDYwCiAgLi9scnVnZW4tcmVwcm8ucHkgY2xlYW51cAoKV29y
a2VycyByZWNsYWltIGZyb20gdGhlIEhPU1QgUk9PVCwgYWZmZWN0aW5nIHRoZSBlbnRpcmUgbWFj
aGluZS4gRHVyYXRpb24KcmVxdWVzdHMgYSBzdG9wOyBhbiBpbi1mbGlnaHQga2VybmVsIHJlY2xh
aW0gY2FsbCBtdXN0IHN0aWxsIGZpbmlzaC4KIiIiCgppbXBvcnQgYXJncGFyc2UKaW1wb3J0IGVy
cm5vCmltcG9ydCBtdWx0aXByb2Nlc3NpbmcgYXMgbXAKaW1wb3J0IG9zCmZyb20gcGF0aGxpYiBp
bXBvcnQgUGF0aAppbXBvcnQgc2lnbmFsCmltcG9ydCBzeXMKaW1wb3J0IHRpbWUKCgpDR1JPT1Qg
PSBQYXRoKCcvc3lzL2ZzL2Nncm91cCcpCkNHUk9VUCA9IENHUk9PVCAvICdscnVnZW4tcmVwcm8n
CgoKZGVmIGNoZWNrX2hvc3QoKToKICAgIGlmIG9zLmdldGV1aWQoKSAhPSAwOgogICAgICAgIHJh
aXNlIFJ1bnRpbWVFcnJvcignUnVuIGFzIHJvb3Qgb24gdGhlIHRlc3Qgc2VydmVyLicpCiAgICBp
ZiBub3QgKENHUk9PVCAvICdjZ3JvdXAuY29udHJvbGxlcnMnKS5leGlzdHMoKToKICAgICAgICBy
YWlzZSBSdW50aW1lRXJyb3IoJ0V4cGVjdGVkIGNncm91cCB2MiBhdCAvc3lzL2ZzL2Nncm91cC4n
KQogICAgaWYgKENHUk9PVCAvICdtZW1vcnkuY3VycmVudCcpLmV4aXN0cygpOgogICAgICAgIHJh
aXNlIFJ1bnRpbWVFcnJvcignUnVuIGluIHRoZSBob3N0IGNncm91cCBuYW1lc3BhY2UsIG5vdCBh
IHN1YnRyZWUuJykKICAgIGlmIG5vdCAoQ0dST09UIC8gJ21lbW9yeS5yZWNsYWltJykuZXhpc3Rz
KCk6CiAgICAgICAgcmFpc2UgUnVudGltZUVycm9yKCdUaGUgaG9zdCByb290IGhhcyBubyBtZW1v
cnkucmVjbGFpbSBpbnRlcmZhY2UuJykKICAgIGlmIGludChQYXRoKCcvc3lzL2tlcm5lbC9tbS9s
cnVfZ2VuL2VuYWJsZWQnKS5yZWFkX3RleHQoKSwgMCkgIT0gMzoKICAgICAgICByYWlzZSBSdW50
aW1lRXJyb3IoJ1RoaXMgdGVzdCBleHBlY3RzIE1HTFJVIGVuYWJsZWQgd2l0aCAweDMuJykKICAg
IHN3YXBzID0gUGF0aCgnL3Byb2Mvc3dhcHMnKQogICAgaWYgc3dhcHMuZXhpc3RzKCkgYW5kIGxl
bihzd2Fwcy5yZWFkX3RleHQoKS5zcGxpdGxpbmVzKCkpID4gMToKICAgICAgICByYWlzZSBSdW50
aW1lRXJyb3IoJ1RoaXMgdGVzdCBleHBlY3RzIG5vIGFjdGl2ZSBzd2FwLicpCgoKZGVmIHByZXBh
cmUoY291bnQpOgogICAgY2hlY2tfaG9zdCgpCiAgICBDR1JPVVAubWtkaXIoKSAgIyBSZWZ1c2Ug
dG8gcmV1c2UgYW4gZXhpc3RpbmcgcG9wdWxhdGlvbi4KICAgIGNyZWF0ZWQgPSBbXQogICAgdHJ5
OgogICAgICAgIChDR1JPT1QgLyAnY2dyb3VwLnN1YnRyZWVfY29udHJvbCcpLndyaXRlX3RleHQo
JyttZW1vcnlcbicpCiAgICAgICAgKENHUk9VUCAvICdjZ3JvdXAuc3VidHJlZV9jb250cm9sJyku
d3JpdGVfdGV4dCgnK21lbW9yeVxuJykKICAgICAgICBmb3IgaSBpbiByYW5nZShjb3VudCk6CiAg
ICAgICAgICAgIGdyb3VwID0gQ0dST1VQIC8gZidsaXZlLXtpOjA2ZH0nCiAgICAgICAgICAgIGdy
b3VwLm1rZGlyKCkKICAgICAgICAgICAgY3JlYXRlZC5hcHBlbmQoZ3JvdXApCiAgICBleGNlcHQg
QmFzZUV4Y2VwdGlvbjoKICAgICAgICBmb3IgZ3JvdXAgaW4gcmV2ZXJzZWQoY3JlYXRlZCk6CiAg
ICAgICAgICAgIGdyb3VwLnJtZGlyKCkKICAgICAgICBDR1JPVVAucm1kaXIoKQogICAgICAgIHJh
aXNlCiAgICBwcmludChmJ0NyZWF0ZWQge2NvdW50fSBlbXB0eSBjZ3JvdXBzIGluIHtDR1JPVVB9
JykKCgpkZWYgY2xlYW51cCgpOgogICAgaWYgb3MuZ2V0ZXVpZCgpICE9IDA6CiAgICAgICAgcmFp
c2UgUnVudGltZUVycm9yKCdDbGVhbnVwIHJlcXVpcmVzIHJvb3QuJykKICAgIGdyb3VwcyA9IFtw
IGZvciBwIGluIENHUk9VUC5pdGVyZGlyKCkgaWYgcC5pc19kaXIoKV0KICAgIGlmIGFueShub3Qg
cC5uYW1lLnN0YXJ0c3dpdGgoJ2xpdmUtJykgb3Igbm90IHAubmFtZVs1Ol0uaXNkaWdpdCgpCiAg
ICAgICAgICAgZm9yIHAgaW4gZ3JvdXBzKToKICAgICAgICByYWlzZSBSdW50aW1lRXJyb3IoJ1Vu
ZXhwZWN0ZWQgY2hpbGQgY2dyb3VwOyByZWZ1c2luZyBjbGVhbnVwLicpCiAgICBmb3IgZ3JvdXAg
aW4gZ3JvdXBzOgogICAgICAgIGdyb3VwLnJtZGlyKCkgICMgRmFpbHMgaWYgcG9wdWxhdGVkIG9y
IGNvbnRhaW5pbmcgY2hpbGQgY2dyb3Vwcy4KICAgIENHUk9VUC5ybWRpcigpCiAgICBwcmludCgn
UmVtb3ZlZCB0ZXN0IGNncm91cHMuJykKCgpkZWYgcmVjbGFpbV93b3JrZXIocmVxdWVzdCwgc3Rh
cnQsIHN0b3AsIHN0YXRzKToKICAgIHNpZ25hbC5zaWduYWwoc2lnbmFsLlNJR0lOVCwgc2lnbmFs
LlNJR19JR04pCiAgICBzaWduYWwuc2lnbmFsKHNpZ25hbC5TSUdURVJNLCBzaWduYWwuU0lHX0lH
TikKICAgIHN0YXJ0LndhaXQoKQogICAgd2hpbGUgbm90IHN0b3AuaXNfc2V0KCk6CiAgICAgICAg
YmVnYW4gPSB0aW1lLm1vbm90b25pY19ucygpCiAgICAgICAgdHJ5OgogICAgICAgICAgICBmZCA9
IG9zLm9wZW4oQ0dST09UIC8gJ21lbW9yeS5yZWNsYWltJywgb3MuT19XUk9OTFkpCiAgICAgICAg
ICAgIHRyeToKICAgICAgICAgICAgICAgIGlmIG9zLndyaXRlKGZkLCByZXF1ZXN0KSAhPSBsZW4o
cmVxdWVzdCk6CiAgICAgICAgICAgICAgICAgICAgcmFpc2UgT1NFcnJvcignU2hvcnQgbWVtb3J5
LnJlY2xhaW0gd3JpdGUnKQogICAgICAgICAgICBmaW5hbGx5OgogICAgICAgICAgICAgICAgb3Mu
Y2xvc2UoZmQpCiAgICAgICAgICAgIHN0YXRzWzFdICs9IDEKICAgICAgICBleGNlcHQgT1NFcnJv
ciBhcyBleGM6CiAgICAgICAgICAgIGlmIGV4Yy5lcnJubyA9PSBlcnJuby5FQUdBSU46CiAgICAg
ICAgICAgICAgICBzdGF0c1syXSArPSAxCiAgICAgICAgICAgIGVsc2U6CiAgICAgICAgICAgICAg
ICBzdGF0c1szXSArPSAxCiAgICAgICAgICAgICAgICBwcmludChmJ1dvcmtlciB7b3MuZ2V0cGlk
KCl9OiB7ZXhjfScsIGZpbGU9c3lzLnN0ZGVyciwgZmx1c2g9VHJ1ZSkKICAgICAgICAgICAgICAg
IHN0b3Auc2V0KCkKICAgICAgICBlbGFwc2VkID0gdGltZS5tb25vdG9uaWNfbnMoKSAtIGJlZ2Fu
CiAgICAgICAgc3RhdHNbMF0gKz0gMQogICAgICAgIHN0YXRzWzRdICs9IGVsYXBzZWQKICAgICAg
ICBzdGF0c1s1XSA9IG1heChzdGF0c1s1XSwgZWxhcHNlZCkKCgpkZWYgcnVuKGFyZ3MpOgogICAg
Y2hlY2tfaG9zdCgpCiAgICBpZiBub3QgQ0dST1VQLmlzX2RpcigpOgogICAgICAgIHJhaXNlIFJ1
bnRpbWVFcnJvcignUnVuIHByZXBhcmUgZmlyc3QuJykKICAgIGlmICdtZW1vcnknIG5vdCBpbiAo
Q0dST1VQIC8gJ2Nncm91cC5zdWJ0cmVlX2NvbnRyb2wnKS5yZWFkX3RleHQoKS5zcGxpdCgpOgog
ICAgICAgIHJhaXNlIFJ1bnRpbWVFcnJvcignVGhlIHRlc3QgY2dyb3VwIG1lbW9yeSBjb250cm9s
bGVyIGlzIGRpc2FibGVkLicpCiAgICBjb3VudCA9IHN1bShwLmlzX2RpcigpIGZvciBwIGluIENH
Uk9VUC5pdGVyZGlyKCkpCiAgICBpZiBub3QgY291bnQ6CiAgICAgICAgcmFpc2UgUnVudGltZUVy
cm9yKCdUaGUgdGVzdCBjZ3JvdXAgcG9wdWxhdGlvbiBpcyBlbXB0eS4nKQogICAgY3R4ID0gbXAu
Z2V0X2NvbnRleHQoJ2ZvcmsnKQogICAgc3RhcnQsIHN0b3AgPSBjdHguRXZlbnQoKSwgY3R4LkV2
ZW50KCkKICAgICMgT25lIHdyaXRlciBwZXIgcm93OiBjb21wbGV0ZWQsIHN1Y2Nlc3MsIEVBR0FJ
TiwgZXJyb3JzLCB0b3RhbF9ucywgbWF4X25zLgogICAgc3RhdHMgPSBbY3R4LkFycmF5KCdRJywg
NiwgbG9jaz1GYWxzZSkgZm9yIF8gaW4gcmFuZ2UoYXJncy53b3JrZXJzKV0KICAgIHJlcXVlc3Qg
PSBmJ3thcmdzLnJlY2xhaW1fbWlifU0gc3dhcHBpbmVzcz0wXG4nLmVuY29kZSgpCiAgICBjaGls
ZHJlbiA9IFtdCiAgICBpbnRlcnJ1cHRlZCA9IEZhbHNlCgogICAgZGVmIHJlcXVlc3Rfc3RvcChz
aWdudW0sIGZyYW1lKToKICAgICAgICAjIFNldHRpbmcgYW4gRXZlbnQgaGVyZSBjb3VsZCBkZWFk
bG9jayBpZiB0aGUgc2lnbmFsIGludGVycnVwdGVkIGl0cyBsb2NrLgogICAgICAgIG5vbmxvY2Fs
IGludGVycnVwdGVkCiAgICAgICAgaW50ZXJydXB0ZWQgPSBUcnVlCgogICAgb2xkX2hhbmRsZXJz
ID0ge3NpZzogc2lnbmFsLnNpZ25hbChzaWcsIHJlcXVlc3Rfc3RvcCkKICAgICAgICAgICAgICAg
ICAgICBmb3Igc2lnIGluIChzaWduYWwuU0lHSU5ULCBzaWduYWwuU0lHVEVSTSl9CiAgICB0cnk6
CiAgICAgICAgZm9yIHJvdyBpbiBzdGF0czoKICAgICAgICAgICAgY2hpbGQgPSBjdHguUHJvY2Vz
cyh0YXJnZXQ9cmVjbGFpbV93b3JrZXIsIGFyZ3M9KHJlcXVlc3QsIHN0YXJ0LCBzdG9wLCByb3cp
KQogICAgICAgICAgICBjaGlsZC5zdGFydCgpCiAgICAgICAgICAgIGNoaWxkcmVuLmFwcGVuZChj
aGlsZCkKICAgICAgICBwcmludChmJ1J1bm5pbmcge2FyZ3Mud29ya2Vyc30gd29ya2VycyB3aXRo
IHtjb3VudH0gY2dyb3VwczsgJwogICAgICAgICAgICAgIGYne2FyZ3MucmVjbGFpbV9taWJ9IE1p
QiBwZXIgcmVxdWVzdCcsIGZsdXNoPVRydWUpCiAgICAgICAgYmVnYW4gPSB0aW1lLm1vbm90b25p
YygpCiAgICAgICAgbmV4dF9wcmludCA9IGJlZ2FuICsgNQogICAgICAgIHN0b3BfYXQgPSBOb25l
CiAgICAgICAgd2FybmVkID0gRmFsc2UKICAgICAgICBzdGFydC5zZXQoKQogICAgICAgIHdoaWxl
IGFueShjaGlsZC5pc19hbGl2ZSgpIGZvciBjaGlsZCBpbiBjaGlsZHJlbik6CiAgICAgICAgICAg
IG5vdyA9IHRpbWUubW9ub3RvbmljKCkKICAgICAgICAgICAgZmFpbGVkID0gYW55KGNoaWxkLmV4
aXRjb2RlIG5vdCBpbiAoTm9uZSwgMCkgZm9yIGNoaWxkIGluIGNoaWxkcmVuKQogICAgICAgICAg
ICBpZiBpbnRlcnJ1cHRlZCBvciBmYWlsZWQgb3Igbm93IC0gYmVnYW4gPj0gYXJncy5kdXJhdGlv
bjoKICAgICAgICAgICAgICAgIHN0b3Auc2V0KCkKICAgICAgICAgICAgaWYgbm93ID49IG5leHRf
cHJpbnQ6CiAgICAgICAgICAgICAgICBwcmludChmJ3tub3cgLSBiZWdhbjouMWZ9czoge3N1bShz
WzBdIGZvciBzIGluIHN0YXRzKX0gJwogICAgICAgICAgICAgICAgICAgICAgJ2NvbXBsZXRlZCBy
ZXF1ZXN0cycsIGZsdXNoPVRydWUpCiAgICAgICAgICAgICAgICBuZXh0X3ByaW50ID0gbm93ICsg
NQogICAgICAgICAgICBpZiBzdG9wLmlzX3NldCgpIGFuZCBzdG9wX2F0IGlzIE5vbmU6CiAgICAg
ICAgICAgICAgICBzdG9wX2F0ID0gbm93CiAgICAgICAgICAgIGlmIHN0b3BfYXQgaXMgbm90IE5v
bmUgYW5kIG5vdyAtIHN0b3BfYXQgPiA1IGFuZCBub3Qgd2FybmVkOgogICAgICAgICAgICAgICAg
cHJpbnQoJ1N0b3AgcmVxdWVzdGVkOyB3YWl0aW5nIGZvciBpbi1mbGlnaHQgcmVjbGFpbSBjYWxs
cy4nLCBmbHVzaD1UcnVlKQogICAgICAgICAgICAgICAgd2FybmVkID0gVHJ1ZQogICAgICAgICAg
ICB0aW1lLnNsZWVwKDAuMikKICAgICAgICBlbGFwc2VkID0gdGltZS5tb25vdG9uaWMoKSAtIGJl
Z2FuCiAgICBmaW5hbGx5OgogICAgICAgIHN0b3Auc2V0KCkKICAgICAgICBzdGFydC5zZXQoKQog
ICAgICAgIGZvciBjaGlsZCBpbiBjaGlsZHJlbjoKICAgICAgICAgICAgY2hpbGQuam9pbigpCiAg
ICAgICAgZm9yIHNpZywgaGFuZGxlciBpbiBvbGRfaGFuZGxlcnMuaXRlbXMoKToKICAgICAgICAg
ICAgc2lnbmFsLnNpZ25hbChzaWcsIGhhbmRsZXIpCgogICAgY29tcGxldGVkLCBzdWNjZXNzLCBl
YWdhaW4sIGVycm9ycywgdG90YWxfbnMgPSAoCiAgICAgICAgc3VtKHJvd1tpXSBmb3Igcm93IGlu
IHN0YXRzKSBmb3IgaSBpbiByYW5nZSg1KSkKICAgIG1heF9ucyA9IG1heChyb3dbNV0gZm9yIHJv
dyBpbiBzdGF0cykKICAgIHByaW50KGYnQ29tcGxldGVkOiB7Y29tcGxldGVkfSAoc3VjY2Vzczog
e3N1Y2Nlc3N9LCBFQUdBSU46IHtlYWdhaW59LCBlcnJvcnM6IHtlcnJvcnN9KScpCiAgICBwcmlu
dChmJ0VsYXBzZWQ6IHtlbGFwc2VkOi4yZn0gczsgcmVxdWVzdHMvczoge2NvbXBsZXRlZCAvIGVs
YXBzZWQ6LjJmfScpCiAgICBpZiBjb21wbGV0ZWQ6CiAgICAgICAgcHJpbnQoZidMYXRlbmN5OiBt
ZWFuIHt0b3RhbF9ucyAvIGNvbXBsZXRlZCAvIDFlNjouMmZ9IG1zOyAnCiAgICAgICAgICAgICAg
ZidtYXgge21heF9ucyAvIDFlNjouMmZ9IG1zJykKICAgIGlmIGVycm9ycyBvciBhbnkoY2hpbGQu
ZXhpdGNvZGUgIT0gMCBmb3IgY2hpbGQgaW4gY2hpbGRyZW4pOgogICAgICAgIHJhaXNlIFJ1bnRp
bWVFcnJvcignQSByZWNsYWltIHdvcmtlciBmYWlsZWQuJykKICAgIGlmIGludGVycnVwdGVkOgog
ICAgICAgIHJldHVybiAxMzAKICAgIHJldHVybiAwCgoKZGVmIHBvc2l0aXZlKHZhbHVlKToKICAg
IG4gPSBpbnQodmFsdWUpCiAgICBpZiBuIDw9IDA6CiAgICAgICAgcmFpc2UgYXJncGFyc2UuQXJn
dW1lbnRUeXBlRXJyb3IoJ011c3QgYmUgcG9zaXRpdmUuJykKICAgIHJldHVybiBuCgoKZGVmIG1h
aW4oKToKICAgIHBhcnNlciA9IGFyZ3BhcnNlLkFyZ3VtZW50UGFyc2VyKGRlc2NyaXB0aW9uPV9f
ZG9jX18sCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBmb3JtYXR0ZXJfY2xh
c3M9YXJncGFyc2UuUmF3RGVzY3JpcHRpb25IZWxwRm9ybWF0dGVyKQogICAgY29tbWFuZHMgPSBw
YXJzZXIuYWRkX3N1YnBhcnNlcnMoZGVzdD0nY29tbWFuZCcsIHJlcXVpcmVkPVRydWUpCiAgICBw
ID0gY29tbWFuZHMuYWRkX3BhcnNlcigncHJlcGFyZScsIGhlbHA9J2NyZWF0ZSBlbXB0eSBsaXZl
IGNncm91cHMnKQogICAgcC5hZGRfYXJndW1lbnQoJy0tbGl2ZScsIHR5cGU9cG9zaXRpdmUsIGRl
ZmF1bHQ9MTAwMCkKICAgIHAgPSBjb21tYW5kcy5hZGRfcGFyc2VyKCdydW4nLCBoZWxwPSdpc3N1
ZSBjb25jdXJyZW50IGhvc3Qtcm9vdCByZWNsYWltIHJlcXVlc3RzJykKICAgIHAuYWRkX2FyZ3Vt
ZW50KCctLXdvcmtlcnMnLCB0eXBlPXBvc2l0aXZlLCBkZWZhdWx0PTgpCiAgICBwLmFkZF9hcmd1
bWVudCgnLS1kdXJhdGlvbicsIHR5cGU9cG9zaXRpdmUsIGRlZmF1bHQ9NjAsIGhlbHA9J3NlY29u
ZHMgdW50aWwgc3RvcCByZXF1ZXN0JykKICAgIHAuYWRkX2FyZ3VtZW50KCctLXJlY2xhaW0tbWli
JywgdHlwZT1wb3NpdGl2ZSwgZGVmYXVsdD0xMDI0KQogICAgY29tbWFuZHMuYWRkX3BhcnNlcign
Y2xlYW51cCcsIGhlbHA9J3JlbW92ZSB0ZXN0IGNncm91cHMnKQogICAgYXJncyA9IHBhcnNlci5w
YXJzZV9hcmdzKCkKICAgIGlmIGFyZ3MuY29tbWFuZCA9PSAncHJlcGFyZSc6CiAgICAgICAgcHJl
cGFyZShhcmdzLmxpdmUpCiAgICBlbGlmIGFyZ3MuY29tbWFuZCA9PSAncnVuJzoKICAgICAgICBy
ZXR1cm4gcnVuKGFyZ3MpCiAgICBlbHNlOgogICAgICAgIGNsZWFudXAoKQogICAgcmV0dXJuIDAK
CgppZiBfX25hbWVfXyA9PSAnX19tYWluX18nOgogICAgdHJ5OgogICAgICAgIHN5cy5leGl0KG1h
aW4oKSkKICAgIGV4Y2VwdCBLZXlib2FyZEludGVycnVwdDoKICAgICAgICBzeXMuZXhpdCgxMzAp
CiAgICBleGNlcHQgKE9TRXJyb3IsIFJ1bnRpbWVFcnJvciwgVmFsdWVFcnJvcikgYXMgZXhjOgog
ICAgICAgIHByaW50KGYnRXJyb3I6IHtleGN9JywgZmlsZT1zeXMuc3RkZXJyKQogICAgICAgIHN5
cy5leGl0KDEpCg==
--000000000000b450f30660f17354--
