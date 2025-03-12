Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7092C17BB6
	for <rcu@vger.kernel.org>; Wed, 12 Mar 2025 11:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741780118; cv=none; b=Pj7hdE3l9iO3JDPibYFmpKLHCvlHyGWQ2O1XRLmHQ7NuwAPpW+vIRbxsfpD5Tj98wInxLi7d7YpqJKb0ziqzaDAMsa+h+J2mSawnH6LOUSWTaQeN5dWNqGi+jH4UdLmp5WGe6tOZmZiexb2VJdjMj6g+AmItgxsSwIjtDDrlV6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741780118; c=relaxed/simple;
	bh=Kgod/bkChKNvWAk+utLk+E9WE0pDt83VbwpFUw6HAuE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JSqEzuGvu5iJ+Z7aZmMlIhhtxjrc6s18I1QdxNpMqGRJ5Xbpsxys1aggLCrpQRmX/twmpfU3Hy0Fq2HhO3yBt+S/0e4rUbRmO6r4C8o4Xp8VE7FXD6Oa5C06XgnfspC3JovVca1T8xRECJh1Er5YBk6YCKwfeGUlAoKGph7LmOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=nPrFlKfH; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="nPrFlKfH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741780114; x=1742039314;
	bh=HInmDeSxbbW0+Qq88H4iBiYbF79g8W/WWDbF6VHeAnE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=nPrFlKfHATsp9T9XYxvfhNsagwXXy+2jJvTVHdrStntAMCzUqFQqNof/O597kmGeU
	 avH7WI62wCyIcvjr9xtcQEnMsv+7x4JS91X+60k2zSoSacvqBwxAV19Ykzh5J1T3wu
	 WN+qrlPwzvb6OPqxBW6YaaXqtLhry2iPFfYZP4lcyIPxTITHKf4uRB7X9qZgLa7Qg2
	 2skcNSbDjzix9MEk/Aug5xNzOczueEI/hceBgAnXrTMELQlv9DlvuuL6f2CzuwJPJ0
	 V+NCr4PDkxhv9BNmRSTuve4N3WN321mwixa/bga36uByrRbFr1Z3Vl7fNr5hMc0Dtk
	 gsPf+JcPZ2M3w==
Date: Wed, 12 Mar 2025 11:48:30 +0000
To: I Hsin Cheng <richard120310@gmail.com>, rostedt@goodmis.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org, josh@joshtriplett.org, boqun.feng@gmail.com, urezki@gmail.com, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, qiang.zhang1211@gmail.com, ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, dakr@kernel.org, rcu@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH] rust: sync: rcu: Mark Guard methods as inline
Message-ID: <D8E9IKGUUUJZ.2797G3WP1GVA3@proton.me>
In-Reply-To: <20250312101723.149135-1-richard120310@gmail.com>
References: <20250312101723.149135-1-richard120310@gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 6a5dbfa6befa34639ff2342d1efe2bf27311fbc5
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed Mar 12, 2025 at 11:17 AM CET, I Hsin Cheng wrote:
> Currenyly the implementation of "Guard" methods are basically wrappers
> around rcu's function within kernel. Building the kernel with llvm
> 18.1.8 on x86_64 machine will generate the following symbols:
>
> $ nm vmlinux | grep ' _R'.*Guard | rustfilt
> ffffffff817b6c90 T <kernel::sync::rcu::Guard>::new
> ffffffff817b6cb0 T <kernel::sync::rcu::Guard>::unlock
> ffffffff817b6cd0 T <kernel::sync::rcu::Guard as core::ops::drop::Drop>::d=
rop
> ffffffff817b6c90 T <kernel::sync::rcu::Guard as core::default::Default>::=
default
>
> These Rust symbols are basically wrappers around functions
> "rcu_read_lock" and "rcu_read_unlock". Marking them as inline can
> reduce the generation of these symbols, and saves the size of code
> generation for 100 bytes.
>
> $ ./scripts/bloat-o-meter vmlinux_old vmlinux_new
> add/remove: 0/8 grow/shrink: 0/0 up/down: 0/-100 (-100)
> Function                                     old     new   delta
> _RNvXs_NtNtCsaYBeKL739Xz_6kernel4sync3rcuNtB4_5GuardNtNtCsdaXADs8PRFB_4co=
re7default7Default7default       9       -      -9
> _RNvXs0_NtNtCsaYBeKL739Xz_6kernel4sync3rcuNtB5_5GuardNtNtNtCsdaXADs8PRFB_=
4core3ops4drop4Drop4drop       9       -      -9
> _RNvMNtNtCsaYBeKL739Xz_6kernel4sync3rcuNtB2_5Guard6unlock       9       -=
      -9
> _RNvMNtNtCsaYBeKL739Xz_6kernel4sync3rcuNtB2_5Guard3new       9       -   =
   -9
> __pfx__RNvXs_NtNtCsaYBeKL739Xz_6kernel4sync3rcuNtB4_5GuardNtNtCsdaXADs8PR=
FB_4core7default7Default7default      16       -     -16
> __pfx__RNvXs0_NtNtCsaYBeKL739Xz_6kernel4sync3rcuNtB5_5GuardNtNtNtCsdaXADs=
8PRFB_4core3ops4drop4Drop4drop      16       -     -16
> __pfx__RNvMNtNtCsaYBeKL739Xz_6kernel4sync3rcuNtB2_5Guard6unlock      16  =
     -     -16
> __pfx__RNvMNtNtCsaYBeKL739Xz_6kernel4sync3rcuNtB2_5Guard3new      16     =
  -     -16
> Total: Before=3D23385830, After=3D23385730, chg -0.00%
>
> Link: https://github.com/Rust-for-Linux/linux/issues/1145
> Signed-off-by: I Hsin Cheng <richard120310@gmail.com>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno

