Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54311FCCFD;
	Wed, 19 Feb 2025 16:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739983241; cv=none; b=ONwUfFBDPsARDx7QWbZPLcemznoJPK645VyTK+pdNBuX7LgtXJTeH9gInV2Ip7zKObiw4rB3fZsstgxXpWL84lAqeLeGFEUTZd5EMls5cKAaRI5vDp5rFeAGXV2791M8Hr9jIesVfDimoD12KVKnb2ugNDil2NQw/zkvoghFl4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739983241; c=relaxed/simple;
	bh=FIoMuFSQ07R4o7KPNr9JeFn01rMJbvd5w5qUNvpz920=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=RnbM+hShkMHQzMQduwlcFRZ9kcqddhToAk07T/w64IL4yNehEOOZGT6JK4I1en/e+IVLk/cpRVQosMbgrpMh0B8BXiDW++Zr06CQrHJpC0tmfamUUBx0bO6UNRg4faJ5HC/4x3NU2imAV71wtLzH8hXzJ9eIudtUeJmgdqREtHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hawEzdym; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hawEzdym"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c0b9f35dc7so101295285a.2;
        Wed, 19 Feb 2025 08:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739983238; x=1740588038; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xpi4TVSx9yEIiCT1ccXBg1RQMkm0prwwjlpAEx2L3Vs=;
        b=hawEzdymHHek2vYP07WhbTYSb4N8ZpsWQtP7PYww6Vy1dIfH5h8ghbyrcdTd7NmBfA
         xVLwJFlNrWS6G11+fJERJFrjo5xAkJ3cd5+khc5svc/FYDGydgFpviATtK5qyb+q1WQJ
         uKrcbXlEMOKoo/aM67Sgh5KUnp2mGoev02BVMg054Z3b8oH/G5psrMxL7NeQ777vLCH/
         D9tfI2o2fjA4y/PONjqjy5/CcEYuyeIfC8jiEaak6gkOV2JG6vUKHION2jz3tYTZIQRH
         HzCCUrTs351Y0kKyeck1WFMg4lYPqXKeNzymYq2E765Hk05iZLWy+i1OhfNsZcS946SF
         claw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739983238; x=1740588038;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xpi4TVSx9yEIiCT1ccXBg1RQMkm0prwwjlpAEx2L3Vs=;
        b=LcjdyVCqWiTlNJtHS/wNjrRoAqe0s7ccZ+KYnGgf9jiU+6dGmhWqwzD4T9jD+7hSTR
         c/K++Pavm35gPRyxi5vvXSWEyY/cHUvMPmjsSx8HUGEhzpLoCkAUQz+d433aH0HacgQ1
         KZybJUKqTAH4FwDL14oaxtR6SZwKsVogxKn2dOpGAMbgvOytTKbS8/xJD1cjHzbffHEp
         /d6tFNtc/BaKlUH8mr7OMKueboKpgTIZYGctRoxBmG1O0N1/CXSzEfwSZ2wy2i23gSio
         79oatH+tUb0DnNFGxV7gfUI6i4zykCZ/WKjnr0EFOvNCYkvgb6d7i34LkFJFfXPDfnM9
         zf3g==
X-Forwarded-Encrypted: i=1; AJvYcCWNJzFVDaESI6hJjx80+vA78LvrNNEFtlT7QtJ4JSBC9iARp0YriR4tpgBpx51uEptgMs8+EeKshDo=@vger.kernel.org, AJvYcCWUHWwBy0KInVnJ8VTpHIXeZ0QGDyvSqbrBL3hV6uIaQkjYox2ejIGYS+Nynz8j4Cji0Kkn@vger.kernel.org
X-Gm-Message-State: AOJu0YxlzSaOtr+2DFC2/4fm0yjA3FMWd1huaHmworbH3jN2qyxNmmuX
	ZAikucucgl2K/BpiDucsCvWdmfNgZU/1JdW53UdCsvqsmiTStq4k
X-Gm-Gg: ASbGncuqTwXs6n8hirMW3Yr4rFGdqH8GPNqKnIhVzZiS76dXxxqwFp1bZdaWguN3kHj
	YA6NMmI6zifnwGC8WvG9xQQnXldN1t/lxVMg9sWhbdcqTMRErFBL9aZ5p8hkDWfcCKMlApz+g2c
	atTthYShEDMqgr7KnDjoV6u65ksU82QgCQIAYLOT6FNMiQvFtVbjISMesPi8w3DajCFwBBfHOyF
	pjZmeJq6k8HQMAJ4nWs3XObrcmHmrXSE8fRouoHf86BqwDPU7Ijm23jOpwR6zsW6kOAcU11lHU=
X-Google-Smtp-Source: AGHT+IEbuLd5HABKsV2aaCeyqHdmc714c4tXv8nksALYv3eJ2MSAwcyoxK6FMyiIX6qmIK88BOOKGA==
X-Received: by 2002:a05:620a:4591:b0:7c0:b0eb:4fa9 with SMTP id af79cd13be357-7c0b51cde08mr664398285a.5.1739983238153;
        Wed, 19 Feb 2025 08:40:38 -0800 (PST)
Received: from smtpclient.apple ([2402:d0c0:11:86::1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0af0aceb1sm201588685a.89.2025.02.19.08.40.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Feb 2025 08:40:36 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [Patch v2] doc/RCU/listRCU: refine example code for eliminating
 stale data
From: Alan Huang <mmpgouride@gmail.com>
In-Reply-To: <20250218005047.27258-1-richard.weiyang@gmail.com>
Date: Thu, 20 Feb 2025 00:40:20 +0800
Cc: paulmck@kernel.org,
 frederic@kernel.org,
 neeraj.upadhyay@kernel.org,
 rcu@vger.kernel.org,
 linux-doc@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <AB18BC5D-AD55-46DF-939C-44DFA845D168@gmail.com>
References: <20250218005047.27258-1-richard.weiyang@gmail.com>
To: Wei Yang <richard.weiyang@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)

On Feb 18, 2025, at 08:50, Wei Yang <richard.weiyang@gmail.com> wrote:
>=20
> This patch adjust the example code with following two purpose:
>=20
>  * reduce the confusion on not releasing e->lock
>  * emphasize e is valid and not stale with e->lock held
>=20
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> CC: Boqun Feng <boqun.feng@gmail.com>
> CC: Alan Huang <mmpgouride@gmail.com>
>=20
> ---
> v2:
>  * add the missing parameter *key
>  * make function return struct audit_entry
> ---
> Documentation/RCU/listRCU.rst | 10 ++++++----
> 1 file changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/RCU/listRCU.rst =
b/Documentation/RCU/listRCU.rst
> index ed5c9d8c9afe..d8bb98623c12 100644
> --- a/Documentation/RCU/listRCU.rst
> +++ b/Documentation/RCU/listRCU.rst
> @@ -334,7 +334,7 @@ If the system-call audit module were to ever need =
to reject stale data, one way
> to accomplish this would be to add a ``deleted`` flag and a ``lock`` =
spinlock to the
> ``audit_entry`` structure, and modify audit_filter_task() as follows::
>=20
> - static enum audit_state audit_filter_task(struct task_struct *tsk)
> + static struct audit_entry *audit_filter_task(struct task_struct =
*tsk, char **key)
> {
> struct audit_entry *e;
> enum audit_state   state;
> @@ -346,16 +346,18 @@ to accomplish this would be to add a ``deleted`` =
flag and a ``lock`` spinlock to
> if (e->deleted) {
> spin_unlock(&e->lock);
> rcu_read_unlock();
> - return AUDIT_BUILD_CONTEXT;
> + return NULL;
> }
> rcu_read_unlock();
> if (state =3D=3D AUDIT_STATE_RECORD)
> *key =3D kstrdup(e->rule.filterkey, GFP_ATOMIC);
> - return state;
> + /* As long as e->lock is held, e is valid and
> + * its value is not stale */
> + return e;
> }
> }
> rcu_read_unlock();
> - return AUDIT_BUILD_CONTEXT;
> + return NULL;
> }
>=20
> The ``audit_del_rule()`` function would need to set the ``deleted`` =
flag under the
> --=20
> 2.34.1
>=20

I think it=E2=80=99s good enough to illustrate the intention here:

Reviewed-by: Alan Huang <mmpgouride@gmail.com>

Boqun, there is an unreviewed doc patch[1] that fixes the section

 =E2=80=9CUsing RCU hlist_nulls to protect list and objects=E2=80=9D

[1] =
https://lore.kernel.org/rcu/20240326124431.77430-1-mmpgouride@gmail.com/

: )



