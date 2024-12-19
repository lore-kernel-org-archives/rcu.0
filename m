Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E66E1BDABE;
	Thu, 19 Dec 2024 22:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734647904; cv=none; b=p2fb7mEH7mHQGuxkH7dDt+PNVUHz7Hr6oXYD6dOt8ZlW7n0Rury1y6V6ukp3ZLPijFhZpnFO891YlIzlKl0Ciq8nXUi33haHNH7m6dIbGS6xsEDOl6ghA6L7mEMNMsZDpMDNikjEMjBbj+eiEMYPUzcd0fCtQz+bo881Fm1D3mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734647904; c=relaxed/simple;
	bh=kmuCXo0uPrymW36ur6yMH1l374CxKIYaEzJ+YIAXmkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Px06feJrkdi54z+HBenmwNeAEfCF88BYI+jAKQfEamqKR9fmhJvf4WiEAsBlZtgUym7gcAgej/Co45o3P+3Skg/72r31SXVVfKQk110r9hCYEeWIT4QZUEkKb9Rx9RbbfXGrTwaT9oB+1Wc4YWUbIv4bWahqJZgfJK9slELYzGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WtiL48/l; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtiL48/l"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5cecbddb574so2046351a12.1;
        Thu, 19 Dec 2024 14:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734647901; x=1735252701; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Fypy7ih5xqzKL0j86zOr8ms4On1cErKk4NTK8EFm5fI=;
        b=WtiL48/llLdb/HP4tOLv9bmXoI4nON5Rj6RmJvV0YoQW1vKnccQfdckszfBe/RQSgx
         CA8FnYOZGwwbtiP5H1HVJaAckA7tCw9nVPVBourUjafe8koOA0SjeAabWRKPilqO0k8Z
         MvKYXUcxOk7rWD+buWtL/OhU8lxE/9XfVpNh9DrSfDPlKFUaMF81iN5YqIt8ZOsz0hMe
         yZbh1MWclTev+vfkOUTzCbr8V2T9Sf6AaLlBYdLO1QYQ5NaJ+7RK6Ire9xUjO+3t4Kvz
         bZbec32tp00GdVqceNYY9n03dUs7RJPhvcl7U5QcrxEjF1v+ul3AHpyk2WO1qySF0cij
         Gpag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734647901; x=1735252701;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fypy7ih5xqzKL0j86zOr8ms4On1cErKk4NTK8EFm5fI=;
        b=U7Fy8Vq7KGIFG29MVJjvD5yB2iJ1orgGrXPMHtaZPhFqrJkQey0JUslp8MjBeFFFaV
         FVIfbrraiM/1JeDwJcIqmgaTzPHPeOw/eDg2GdRm2qJiXQjGZLYpCxXKQz4LTJ14m3XM
         APkTCQMscA3KhmpmofSK5Fhg8stCYICL735k9n4kHIY5yKHhoyHkRxqGuwgSsKVH9zYN
         ksK/ojXAmLFnMMMzV7ct94hmTL5MTWwPvVyj1SjghW8ajiidHDuwKwf1al0zpn0qTOc3
         diyXZLq3nMthQvi87huMpjbvAjscaBHkkaKit+EiNhcmNwAV7yF+Y8ohmerUYXyYuBDm
         UQ6A==
X-Forwarded-Encrypted: i=1; AJvYcCUPsFHJilkVNvHD9H2Y376FE9PkbyIDEXVEaqUHy9uqRfl5E9qxR6YMCDL1kCo7AiExpf9m4atpGf8v7Q==@vger.kernel.org, AJvYcCVTNkguX41NieN2Mnf7N56D8XFEGsH/ruKA+1LvZYk9Y03F8KQJU3i3lN8TNRaG1Mrso21I@vger.kernel.org
X-Gm-Message-State: AOJu0YyGiLpaBMrMGj6R/hSrqOCW36nXfFZDnzPansJAcq2KrkkfwzF9
	udwDPlzwTpo/JyGfi8NqfGbsDyupsyhVZUx6pdjQYhbjzDOfvRd441wYQvtb0wixO7yzhJo/PbW
	pNQVvCKVP5C72ho7nmmOzh1YkEq8=
X-Gm-Gg: ASbGncu7hsmbBvVuQB1nL4VlREZQiQetj5Od9g3GtRtql7OG0+dithir/GU/QY7UmdM
	m6nm1qIqSvTEznD25n5h4zwmzgyqTleN3bIRD3ls=
X-Google-Smtp-Source: AGHT+IHA42Ne6cfTWSeumD6AKt17HsENhquCXYK7WnQY/ha9nvUwSvmJ5Naq9RjCok1+8dh4HQ8F/IDlgR9xZFMTkK4=
X-Received: by 2002:a05:6402:50d1:b0:5d3:e79b:3b3d with SMTP id
 4fb4d7f45d1cf-5d81de5c72emr406723a12.28.1734647901190; Thu, 19 Dec 2024
 14:38:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c661a771a86267c158d7f2eba1494fe94350fb06.camel@physik.fu-berlin.de>
 <CA+=Fv5Rxrwn0SEMgjufJcxSaB0_gOiKBjXuZnSKzgKakDHeCOw@mail.gmail.com>
 <CA+=Fv5R+8y2hCq7p-xo5qZ0CyinR_0aAndUkoEAweCVs_95SMw@mail.gmail.com>
 <Z1YpKFQGtMWF3yy3@creeky> <CA+=Fv5Q=f-6y=EhZhG2XfZB0O=m+yOiv+gmtmMABVQZieKdwbQ@mail.gmail.com>
 <Z2ClSlwznfuk8Uwr@creeky> <CA+=Fv5RaqHL6MJjvhF-mn3CVY10e=2QqFBSVO6YXLUJ7WV9zGQ@mail.gmail.com>
 <CA+=Fv5RP=NoWo4VeTX7hx103=jP2d-NC-jFo+ePXLBRubCxc_w@mail.gmail.com>
 <ef49a479-2000-42ee-9b10-9f3b6a68ec35@paulmck-laptop> <CA+=Fv5REK+xbA49zD3aYBgG2J1Xw1FWP02qjyyOTrwbzMRXu3w@mail.gmail.com>
 <be4fe590-b41c-4033-91c1-94f10c4f3d40@paulmck-laptop>
In-Reply-To: <be4fe590-b41c-4033-91c1-94f10c4f3d40@paulmck-laptop>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Thu, 19 Dec 2024 23:38:09 +0100
Message-ID: <CA+=Fv5Tk-vbAK72ZOK-bPwvnx9w_1ATH=S9t-LW8gBEgQPYa3A@mail.gmail.com>
Subject: Re: Kernel Oops on alpha with kernel version >=6.9.x
To: paulmck@kernel.org
Cc: Michael Cree <mcree@orcon.net.nz>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, rcu@vger.kernel.org, 
	linux-alpha@vger.kernel.org, "Maciej W. Rozycki" <macro@orcam.me.uk>
Content-Type: text/plain; charset="UTF-8"

> In the past, there have been compiler optimizations that would use a large
> store to update a smaller variable, and then do small stores to fix up the
> clobbered areas.  These were all supposed to have been removed for C11.
> Might some linger in Alpha's compilers?


Hi again,

Making just these (see below) one-liner changes to tree_exp.h and
smp.c respectively, lets me boot kernel 6.12.5 on alpha without
passing any special rcu parameters to the kernel and it also lets me
load/unload my scsi kernel module. Is the alignment of structs just
giving gcc more room to clobber the stack without actually hitting
anything important or is it relevant for how kernel threads access
structs on weak memory-model architectures?

/Magnus

+++ kernel/rcu/tree_exp.h 2024-12-19 18:55:59.091893649 +0100
@@ -940,10 +939,10 @@
 void synchronize_rcu_expedited(void)
 {
  unsigned long flags;
- struct rcu_exp_work rew;
+ struct ____cacheline_aligned_in_smp rcu_exp_work rew;
  struct rcu_node *rnp;
  unsigned long s;


+++ kernel/smp.c        2024-12-19 19:01:20.592819628 +0100
@@ -631,7 +631,7 @@
int smp_call_function_single(int cpu, smp_call_func_t func, void *info,
                             int wait)
 {
        call_single_data_t *csd;
-       call_single_data_t csd_stack = {
+       struct ____cacheline_aligned_in_smp __call_single_data csd_stack = {
                .node = { .u_flags = CSD_FLAG_LOCK | CSD_TYPE_SYNC, },
        };
        int this_cpu;
